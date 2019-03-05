#!/bin/bash
hmmsearch -A "$2_$1.aln" --tblout "$2_$1.txt" "$1.hmm" "$2_prot.fa"
grep -v "^#" "$2_$1.txt"| awk '{print $1}'| awk -F "_" '{print $1}' | sed 's/^/@/' > "tmp_$2_$1"
#grep -A 3  -f tmp_list "$2_1.fastq" | grep -v "^--" > "$2_$1.1.fq" &
#grep -A 3  -f tmp_list "$2_2.fastq" | grep -v "^--" > "$2_$1.2.fq" &
#wait
