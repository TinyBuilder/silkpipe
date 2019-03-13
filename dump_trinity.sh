#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --defline-seq '@$sn[_$rn]/$ri' --split-3 --skip-technical --clip --dumpbase --read-filter pass --threads 8 --gzip
