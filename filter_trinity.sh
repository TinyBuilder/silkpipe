#!/bin/bash
sort $1/*.tmp | uniq > $1/matches
grep -A 3 -f $1/matches $1/1.fq | grep -v "^--" > $1/1_matches.fq &
grep -A 3 -f $1/matches $1/2.fq | grep -v "^--" > $1/2_matches.fq &
paste - - < $1/rna.fa | grep -v -f $1/matches | tr "\t" "\n" > $1/unmatched.fa
wait
