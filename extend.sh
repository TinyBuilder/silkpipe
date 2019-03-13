#!/bin/bash
tadpole.sh in=trinity_$1.Trinity.fasta out=$1/extended.fa extra=$1/unmatched.fa extendleft=10000 extendright=10000 ibb=f mode=extend fastawrap=0
translate6frames.sh in=$1/extended.fa out=stdout.fa frames=3 fastawrap=0 | paste - - | grep -v '\*' | tr '\t' '\n' > $1/extended_prots.fa
