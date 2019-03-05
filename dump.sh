#!/bin/bash
parallel-fastq-dump -s $1 -O $1 --threads 6 --split-spot -W -I --skip-technical --read-filter pass --gzip
