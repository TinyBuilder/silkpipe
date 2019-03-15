#!/bin/bash
if ./assemble.sh $1; then
    ./extend.sh $1
    ./blast.sh $1
    ./annotate.py $1
else
    echo "Assembly failed." >>$1/log.txt
fi
