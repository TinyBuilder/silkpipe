#!/bin/bash
Trinity --seqType fq --max_memory 200G --left "$1/1_seeds.fq.gz" --right "$1/2_seeds.fq.gz" --CPU 32 --SS_lib_type FR --no_bowtie --no_normalize_reads --full_cleanup --output "trinity_$1"
