#!/bin/bash
blastp -query $1/extended_prots.fa -db /data/ncbi/db/nr -out nr_matches.json -task blsatp-fast -num_threads 32 -evalue 1 -outfmt 15
