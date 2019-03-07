#!/bin/bash
Trinity --seqType fq --max_memory 200G --left "$1/1.fq.gz" --right "$1/2.fq.gz" --CPU 32 --SS_lib_type FR --no_bowtie --full_cleanup --output "trinity_$1" --no_normalize_reads
