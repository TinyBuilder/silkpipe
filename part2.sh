#!/bin/bash
if ./assemble.sh $1; then
    ./extend.sh $1
else
    tadpole.sh in=$1/1_seeds.fq.gz in2=$1/2_seeds.fq extra=$1/unmatched.fa.gz out=$1/extended.fa extendleft=10000 extendright=10000 ibb=f mode=extend fastawrap=0
fi
./blast.sh $1
./annotate.py $1
