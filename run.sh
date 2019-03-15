#!/bin/bash
ssh -tt $1 "cd silkpipe; ./dump_trinity.sh $2; ./clean_trinity.sh $2; ./search_all.sh $2"
mkdir $2
scp $1:silkpipe/$2/*.tmp $2
scp $1:silkpipe/$2/rna.fa $2
./filter_trinity.sh $2
pigz $2/*_seeds.fq
scp $2/*_seeds.fq $1:silkpipe/$2
ssh -tt $1 "cd silkpipe; ./assemble.sh $2; ./extend.sh $2; ./blast.sh $2; ./annotate.py $2"
scp $1:silkpipe/$2/*.json $2
