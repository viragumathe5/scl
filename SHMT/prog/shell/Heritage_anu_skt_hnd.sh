#!/bin/sh

#  Copyright (C) 2017-2017 Amba Kulkarni (ambapradeep@gmail.com)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


myPATH=SCLINSTALLDIR/
export SHMT_PATH=$myPATH/SHMT
ANU_MT_PATH=$SHMT_PATH/prog
export LC_ALL=POSIX

TMP_DIR_PATH=$2
OUTSCRIPT=$3
PARSE=$4
TEXT_TYPE=$5
ECHO=$6

DEBUG="ON"
Heritage_Input="YES"

if [ $OUTSCRIPT = "ROMAN" ]; then
 my_converter="$myPATH/converters/wx2utf8roman.out"
 my_converter_wxHindi="$myPATH/converters/wx2utf8roman.out"
fi

if [ $OUTSCRIPT = "DEV" ]; then
  my_converter="$myPATH/converters/wx2utf8.sh"
  my_converter_wxHindi="$myPATH/converters/wxHindi-utf8.sh"
fi

if [ $OUTSCRIPT = "VH" ]; then
  my_converter="$myPATH/converters/wx-velthuis.out"
  my_converter_wxHindi="$myPATH/converters/wx-velthuis.out"
fi

if [ $# -lt 1 ] ; then
  echo "Usage: Heritage_anu_skt_hnd.sh <file> tmp_dir_path [DEV|ROMAN|VH] [NO|Partial|Full] [Prose|Verse] [ECHO|NOECHO]"
fi

cd $TMP_DIR_PATH
fbn=`basename $1` #fbn = file base name
dnm=`dirname $1` #dnm = directory name

temp_files_path=${dnm}/tmp_$fbn

export TMP_FILES_PATH=$temp_files_path

if [ -f "tmp_$fbn"  ] ; then 
  echo "File tmp_$fbn exists. Remove or rename it, and give the command again."
else
#  mkdir -p $temp_files_path

  cmd=s#tmp_dir_scrpt#$temp_files_path\&amp\;outscript=$OUTSCRIPT#g
  cmd1=s#tmp_anu_dir#$temp_files_path#g

###########
#     # First argument: Name of the file
#     # Second argument: no of parses
#     # Third argument: Name of the file with kaaraka analysis for annotation
# Fields 9 and 10: morph analysis corresponding to the kaaraka role and kaaraka role in the 10th field
#     /usr/bin/time -f "%Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)k\n%Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps %C\n" 
#cp $temp_files_path/$fbn.out $temp_files_path/$fbn.pre_parse_out
$ANU_MT_PATH/kAraka/shabdabodha.sh $Heritage_Input $temp_files_path $fbn.out $fbn.kAraka $OUTSCRIPT $PARSE $TEXT_TYPE $ECHO 
#cp $temp_files_path/$fbn.out $temp_files_path/$fbn.post_parse_out
 fi  # PARSE != AVAILABLE ends here
#
###########
# anaphora in the 11th field
        # First argument: Name of the input file
        # Second argument: Name of the output file
     $ANU_MT_PATH/anaphora/anaphora.pl < $temp_files_path/$fbn.out > $temp_files_path/tmp
    mv $temp_files_path/tmp $temp_files_path/$fbn.out


############
# wsd in the 12th field
    $ANU_MT_PATH/wsd/wsd_rules.sh $temp_files_path/$fbn.out $temp_files_path/$fbn.wsd $temp_files_path/$fbn.wsd_upapaxa
    if [ $DEBUG = "OFF" ]; then 
      rm $temp_files_path/$fbn.wsd $temp_files_path/$fbn.wsd_upapaxa
    fi
###########
### Map to hindi
# Color Code in the 13th field
# Chunk/LWG in the 14th field
# map o/p in the 15th field and lwg o/p in 16th field
# gen o/p in the 17th field
    $ANU_MT_PATH/pos/add_colorcode.pl < $temp_files_path/$fbn.out |\
    $ANU_MT_PATH/chunker/lwg.pl  |\
    $ANU_MT_PATH/map/add_dict_mng.pl $SHMT_PATH/data ONE |\
    $ANU_MT_PATH/map/lwg_avy_avy.pl $SHMT_PATH/data hi  |\
    $ANU_MT_PATH/gen/agreement.pl $SHMT_PATH/data $ANU_MT_PATH/gen |\
    $ANU_MT_PATH/gen/call_gen.pl |\
    $ANU_MT_PATH/interface/modify_mo_for_display.pl > $temp_files_path/ttt
    mv $temp_files_path/ttt $temp_files_path/$fbn.out
#
##########
    $ANU_MT_PATH/translation/translate.sh $my_converter_wxHindi < $temp_files_path/$fbn.out > $temp_files_path/../$1_trnsltn
###########

###########
# 1-2: format
# 3: sandhied_word
# 4: word
# 5: format
# 6-8: morph
# 9: morph in context
# 10: kaaraka role
# 11: Anaphora
# 12: WSD
# ** 13: POS
# 13: Color code
# 14: Chunk/LWG
# 15:  map o/p
# 16: lwg o/p
# 17: gen o/p
  cut -f1-7,9-10,11,13,16,17 $temp_files_path/$fbn.out |\
  perl -p -e 's/<([sa])>/<\@$1>/g' |\
  perl -p -e 's/<\/([sa])>/<\/\@$1>/g' |\
  $my_converter |\
  $ANU_MT_PATH/interface/gen_xml.pl 10 |\
  xsltproc $ANU_MT_PATH/interface/xhtml_unicode_sn-hi.xsl - |\
  $ANU_MT_PATH/interface/add_dict_ref.pl $OUTSCRIPT |\
  perl -p -e $cmd  |\
  perl -p -e $cmd1  > $temp_files_path/../$1.html

if [ $DEBUG = "OFF" ]; then 
   rm -rf $temp_files_path/tmp* $temp_files_path/ERR $temp_files_path/in* ERR* $temp_files_path/debug_hindi_gen ${fbn} tmp
fi
$ANU_MT_PATH/reader_generator/extract.pl < $temp_files_path/$fbn.out | $my_converter > $temp_files_path/table.csv
