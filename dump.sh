#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --threads 6 --split-spot -W -I --skip-technical --read-filter pass --gzip
bbmerge.sh in=$1/$1_pass.fastq.gz outa=$1/adapters.fa
bbmerge.sh in=$1/$1_pass.fastq.gz out=$1/merged.fq outu=$1/unmerged.fq.gz ihist=ihist.txt
translate6frames.sh in=$1/merged.fq out=$1/prot.fa.gz frames=3
