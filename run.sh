#!/bin/bash
ssh -tt $1 "cd silkpipe; ./part1.sh $2"
mkdir $2
scp $1:silkpipe/$2/*.tmp $2
scp $1:silkpipe/$2/rna.fa $2
./filter_trinity.sh $2
pigz $2/*_seeds.fq
scp $2/*_seeds.fq $1:silkpipe/$2
ssh -tt $1 "cd silkpipe; ./part2.sh $2"
scp $1:silkpipe/$2/*.json $2
ssh -tt $1 "rm ncbi/public/sra/*; rm -rf silkpipe/SRR*"
