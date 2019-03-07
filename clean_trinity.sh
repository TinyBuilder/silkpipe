#!/bin/bash
bbduk.sh in="$1/$1_1.fastq.gz" in2="$1/$1_2.fastq.gz" out1="$1/1_tmp.fq.gz" out2="$1/2_tmp.fq.gz" ref=$HOME/opt/bbmap/resources/adapters.fa qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 tpe tbo 
bbduk.sh in="$1/1_tmp.fq.gz" in2="$1/2_tmp.fq.gz" out1="$1/1.fq.gz" out2="$1/2.fq.gz" ref=$HOME/opt/bbmap/resources/phix174_ill.ref.fa.gz qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 tpe tbo 
rm $1/$1* $1/*_tmp.fq.gz
