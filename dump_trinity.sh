#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --defline-seq '@$sn[_$rn]/$ri' --split-files --threads 8 --gzip
