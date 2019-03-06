#!/bin/bash
Trinity --seqType fq --max_memory 10G --left "$2_$1.1.fq" --right "$2_$1.2.fq" --CPU 8 --SS_lib_type FR --no_bowtie --no_normalize_reads --full_cleanup --output "trinity_$2_$1"
