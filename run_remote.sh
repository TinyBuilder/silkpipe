#!/bin/bash
if [ -s $2/$3/matches ]; then
    ssh -tt $1 "mkdir silkpipe/$3"
    scp $2/$3/*_seeds.fq.gz $1:silkpipe/$3
    scp $2/$3/unmatched.fa.gz $1:silkpipe/$3
    ssh -tt $1 "cd silkpipe; ./part2_no_assemble.sh $3"
    scp $1:silkpipe/$3/*.json $2/$3
    scp $1:silkpipe/$3/log.txt $2/$3
    ssh -tt $1 "rm -rf silkpipe/SR*"
fi
