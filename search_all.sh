#!/bin/bash
./search.sh Spidroin_MaSp $1 &
./search.sh Spidroin_N $1 &
./search.sh "RP1-2" $1
wait
