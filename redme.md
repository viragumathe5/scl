![samsaadhanii](imgs/samsadhani3.jpg)

The distribution contains various tools related to Sanskrit computations developed under the guidance of Amba Kulkarni since 2002.


## Pre-requisites:
apache HTTP server
bash
lttoolbox
graphviz

libgdbm (required for hash tables in perl)

gcc/g++

flex

bison

perl

python

java (for Ashtadhyayi simulator)

### Perl modules:
Time::Out (0.11 or above)
GDBM_File.pm

### Ocaml
Ocamlpr4 patch

#### The distribution comes in two forms:
a. Following modules bundled together
   Morph analyser, Morph generator, Sandhi, Sandhi splitter, Anusaaraka Skt-Hnd MT system, transliteration modules, Amarakosha and Sankshepa Ramayana
  (scl.tgz)

To install Sanskrit Computational Linguistics tools

a. tar -xvzf scl.tgz 

b. cp appropriate SPEC/spec*.txt file to scl directory. Name it as spec.txt
   Check that the paths are correct, else make necessary changes.

c. ./configure  (./configure_server for server version)

d. make all

e. sudo make install (install_server for server version)


All the packages are available under GPL. You would have received a copy of GPL license with this package.

In case of any queries, please contact ambapradeep@gmail.com.


-- Amba Kulkarni
15th July 2012
----

### History:
We acknowledge the help of ASR Melkote who had given their resources of Morphological Analyser in 2002. This formed a starting point for us. 

Mr. Jain worked on the Sanskrit morphological analyser from 2002-2003 towards his M.Tech. thesis at IIIT-H.

Ms. Sheeba worked as a part of work on her Ph.D. thesis contributed towards the development of morphological analyser from 2004-2006. Her major contribution was for subantas and kridantas.

Mr. Anil Gupta contributed for the development of tinganta analyser between 2006-2007, especially with the Dhaturatnakar entries.

Later from 2004-2006, various students at the Rashtriya Sanskrit Vidyapeetham Tirupati contributed to the development of Sandhi package. Contribution of Ms. Sivaja Nair, Pankaj Vyasa and Ms. Sushama Vempati deserve special mention.

University of Hyderabad later supported further development under the University of Potential Excellence scheme from 2006-2007.

During 2006-2008 Pawan Goyal, IIT Kanpur worked with Amba Kulkarni towards the development of Ashtadhyayi simulator.

Though Amba Kulkarni worked on various modules at her own pace, the project got a boost when the Technology Development for Indian Languages(TDIL)  division of Ministry of Information and Communication Technology supported the activity in the form of a Consortium of 7 Institutes (2009-13).

The Principal Investigators at the 7 institutes are:
Amba Kulkarni, Department of Sanskrit Studies, University of Hyderabad (Consortium Leader)
Dipti Mishra Sharma, IIIT-H, Hyderabad
Girish Nath Jha, Special Center for Sanskrit, JNU, Delhi
Veeranarayan Pandurangi, JRRSU, Jaipur
Tirumala Kulkarni, PPVP, Bangalore
S. S. Murty, RSVP, Tirupati
Shrinivas Varkhedi, Director, Sanskrit Academy, Hyderabad

Under this project on 'Development of Sanskrit Computational tools and Sanskrit-Hindi Machine Translation system', following tools have been developed:

a. Morph analyser
b. Morph generator
c. Sandhi
d. Sandhi Splitter
e. Sanskrit-Hindi Machine Translation system (Sampark and Anusaaraka models)
f. Compound Processor

All these modules were developed at the Department of Sanskrit Studies, University of Hyderabad.

Various consortium members have contributed by developing annotated tests for building these modules. In addition JNU developed a POS tagger and IIIT-H deveoped a POS tagger and a parser, which are not part of this distribution.

During 2015-17 Amba Kulkarni was awarded a fellowship at Indian Institute of Advanced Study, Shimla. During this period she improved the parsing algorithms taking into account the yogyataa as a constraint.

Following persons had major contribution in the development of the tools:
a. Dr. Sheeba
b. Dr. Devanand Shukl
c. Mr. Anil Gupta
d. Ms. Bhavani
e. Ms. Gauri
f. Ms. Kiranmayi
g. Mr. Karunakar
h. Dr. Shivaja
i. Dr. Shailaja
j. Dr. Pavankumar Satuluri
k. Dr. Arjun K

In addition Converters and Transliteration modules for converting/transliterating from one scheme to the other are developed. Following schemes have been addressed.
a. Unicode Devanagari (UTF-8)
b. WX
c. Velthuis
d. Itrans
e. SLP
f. Kyoto Harvard

Dr. Sivaja Nair worked on her Ph.D. thesis on the Amarakosha from 2007-2011. The package she developed in the process is also available for distribution.

Dr. Anil Kumar developed the Compound processor as a part of his PhD thesis from 2008-2011.

Dr. Shailaja developed the concordance of three Paninian Dhatuvrttis as a part of her PhD thesis from 2009-13.

Dr. Pavankumar Satuluri developed the compound generator as a part of his PhD thesis (2011-15).

Dr. Arjun developed the Nyaayacitradiipikaa, an analyser for Navya Nyaya Expressions as a prt of his PhD thesis (2013-17).

Since 2007 Amba Kulkarni is also collaborating with Gerard Huet, INRIA. As a result of this collaboration, an inter-communication between the Sanskrit Heritage tools and the Anusaaraka tools has been possible.

Finally I would like to acknowledge Prof. K V Ramkrishnamacharyulu for his guidance throughout the development of these tools.

----
