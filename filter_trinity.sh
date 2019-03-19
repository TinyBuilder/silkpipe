#!/bin/bash
sort $1/*.tmp | awk -F '/' '{print $1}' | uniq >$1/matches
pigz -d $1/1.fq.gz $1/2.fq.gz $1/rna.fa.gz
grep -A 3 -f $1/matches $1/1.fq | grep -v "^--" >$1/1_seeds.fq &
grep -A 3 -f $1/matches $1/2.fq | grep -v "^--" >$1/2_seeds.fq &
paste - - <$1/rna.fa | grep -v -f $1/matches | tr "\t" "\n" >$1/unmatched.fa
wait
