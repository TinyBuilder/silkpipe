#!/bin/bash
blastp -query $1/extended_prots.fa -db /data/ncbi/db/nr -out nr_matches.json -task blastp-fast -num_threads 32 -evalue 0.00001 -outfmt 15
