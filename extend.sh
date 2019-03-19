#!/bin/bash
if tadpole.sh in=trinity_$1.Trinity.fasta out=$1/extended.fa extra=$1/unmatched.fa.gz extendleft=10000 extendright=10000 ibb=f mode=extend fastawrap=0; then
    :
else
    tadpole.sh in=$1/1_seeds.fq.gz in2=$1/2_seeds.fq extra=$1/unmatched.fa.gz out=$1/extended.fa extendleft=10000 extendright=10000 ibb=f mode=extend fastawrap=0
fi
translate6frames.sh in=$1/extended.fa out=stdout.fa frames=3 fastawrap=0 | paste - - | grep -v '\*' | tr '\t' '\n' >$1/extended_prots.fa
