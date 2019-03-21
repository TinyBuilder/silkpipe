#!/bin/bash
prefetch $1
./dump_trinity.sh $1
bbduk.sh in=$1/$1_pass_1.fastq.gz in2=$1/$1_pass_2.fastq.gz out=$1/1.fq.gz out2=$1/2.fq.gz ref=$HOME/opt/bbmap/resources/phix174_ill.ref.fa.gz qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 fastawrap=0 tpe tbo
rm $1/$1*
reformat.sh in=$1/1.fq.gz in2=$1/2.fq.gz out=$1/rna.fa.gz fastawrap=0 &
translate6frames.sh in=$1/1.fq.gz in2=$1/2.fq.gz out="$1/prot.fa.gz" fastawrap=0
wait
./search_all.sh $1
./filter_trinity.sh $1
if [ -s $1/matches ]; then
    pigz $1/*_seeds.fq
    pigz $1/unmatched.fa
    Trinity --seqType fq --max_memory 10G --left "$1/1_seeds.fq.gz" --right "$1/2_seeds.fq.gz" --CPU 8 --SS_lib_type FR --no_bowtie --no_normalize_reads --full_cleanup --output "trinity_$1"
    rm -rf ~/ncbi/public/sra/*
else
    touch $1/no_matches
fi

rm $1/*.fq $1/*.fa
#mv $1 "/media/ivan/Ivan's Backup"
