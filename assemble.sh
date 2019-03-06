#!/bin/bash
tadpole.sh in=$1/merged.fq.gz out=$1/contigs.fa fastawrap=0 overwrite=true
translate6frames.sh in=$1/contigs.fa out=$1/contig_prots.fa fastawrap=0 frames=3 overwrite=true
