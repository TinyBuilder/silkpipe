#!/bin/bash
prefetch $1
./dump_trinity.sh $1
./clean_trinity.sh $1
./search_all.sh $1
