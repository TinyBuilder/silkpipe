#!/bin/bash
sort $1/*.tmp | uniq > $1/matches
zgrep -A 3 -f $1/matches $1/1.fq.gz | grep -v "^--" > $1/1_seeds.fq &
zgrep -A 3 -f $1/matches $1/2.fq.gz | grep -v "^--" > $1/2_seeds.fq &
zcat $1/1.fq.gz | paste - - - - | cut -f 1,2 | grep -v -f $1/matches | tr "\t" "\n" | gzip > $1/1_unmatched.fa &
zcat $1/2.fq.gz | paste - - - - | cut -f 1,2 | grep -v -f $1/matches | tr "\t" "\n" | gzip > $1/2_unmatched.fa &
wait
