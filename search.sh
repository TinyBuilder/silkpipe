#!/bin/bash
hmmsearch -A "$2/$1.aln" --tblout "$2/$1.txt" "$1.hmm" "$2/prot.fa.gz"
grep -v "^#" "$2/$1.txt"| awk '{print $1}'| awk -F "_" '{print $1}' | sed 's/^/@/' > "$2/$1.tmp"
#grep -A 3  -f tmp_list "$2_1.fastq" | grep -v "^--" > "$2_$1.1.fq" &
#grep -A 3  -f tmp_list "$2_2.fastq" | grep -v "^--" > "$2_$1.2.fq" &
#wait
