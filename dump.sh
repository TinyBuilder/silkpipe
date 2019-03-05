#!/bin/bash
parallel-fastq-dump -s $1 --defline-seq '@$sn[_$rn]/$ri' --defline-qual '+$sn[_$rn]/$ri' --split-files --threads 6 