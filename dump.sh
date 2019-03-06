#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --threads 24 --split-spot -W -I --skip-technical --read-filter pass --gzip
bbmerge.sh in=$1/$1_pass.fastq.gz outa=$1/adapters.fa
bbmerge-auto.sh in=$1/$1_pass.fastq.gz adapters=$1/adapters.fa out=$1/merged.fq.gz rem k=62 extend2=50 ecct
translate6frames.sh in=$1/merged.fq out=$1/prot.fa.gz frames=3
