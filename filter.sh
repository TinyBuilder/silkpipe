#!/bin/bash
sort tmp_$1* | uniq > "$1_list"
grep -A 3  -f "$1_list" "$1_1.fastq" | grep -v "^--" > "$1.1.fq" &
grep -A 3  -f "$1_list" "$1_2.fastq" | grep -v "^--" > "$1.2.fq" &
paste - - < "$1_rna.fa" | grep -v -f "$1_list" | tr "\t" "\n" > "$1_unmatched.fa"
wait
