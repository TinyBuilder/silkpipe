#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --defline-seq '@$sn[_$rn]/$ri' --split-files --threads 8 --gzip
translate6frames.sh in="$1/1.fq.gz" out="$1/1_prot.fa.gz" fastawrap=0 &
translate6frames.sh in="$1/2.fq.gz" out="$1/2_prot.fa.gz" fastawrap=0 &
wait
