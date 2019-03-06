#!/bin/bash
hmmsearch -o $2/$1.log -A "$2/$1.aln" --tblout "$2/$1.txt" "$1.hmm" "$2/contig_prots.fa"
grep -v "^#" "$2/$1.txt"| awk '{print $1}' > "$2/$1.tmp"
