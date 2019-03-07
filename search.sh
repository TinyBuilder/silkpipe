#!/bin/bash
hmmsearch -o "$2/$1.report" -A "$2/$1.aln" --tblout "$2/$1.txt" "$1.hmm" "$2/prot.fa.gz"
grep -v "^#" "$2/$1.txt"| awk '{print $1}'| awk -F "_" '{print $1}' | sed 's/^/@/' > "$2/$1.tmp"
