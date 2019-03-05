#!/bin/bash
sort $1/*.tmp | uniq > $1/matches
grep -A 3 -f $1/matches $1/merged.fq | grep -v "^--" > $1/seeds.fq &
paste - - - - < $1/merged.fq | grep -v -f $1/matches | cut -f 1,2 | tr "\t" "\n" > $1/unmatched.fa
wait
