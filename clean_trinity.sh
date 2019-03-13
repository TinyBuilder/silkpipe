#!/bin/bash
#bbduk.sh in="$1/$1_1.fastq.gz" in2="$1/$1_2.fastq.gz" out1="$1/1_tmp.fq.gz" out2="$1/2_tmp.fq.gz" ref=$HOME/opt/bbmap/resources/adapters.fa qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 tpe tbo 
#rm $1/$1* $1/*_tmp.fq.gz
bbduk.sh in=$1/$1_pass_1.fastq.gz in2=$1/$1_pass_2.fastq.gz out=$1/1.fq out2=$1/2.fq ref=$HOME/opt/bbmap/resources/phix174_ill.ref.fa.gz qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 fastawrap=0 tpe tbo 
#removehuman.sh in="stdin.fq" out="stdout.fq" interleaved=true |\
#reformat.sh in="stdin.fq" out1="$1/1.fq.gz" out2="$1/2.fq.gz" fastawrap=0 interleaved=true
rm $1/$1*
reformat.sh in=$1/1.fq in2=$1/2.fq out=$1/rna.fa fastawrap=0 &
translate6frames.sh in=$1/1.fq in2=$1/2.fq out="$1/prot.fa.gz" fastawrap=0
wait
