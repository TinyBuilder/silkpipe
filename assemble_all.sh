#!/bin/bash
Trinity --seqType fq --max_memory 200G --left "$1/1.fq" --right "$1/2.fq" --CPU 32 --SS_lib_type FR --no_bowtie --full_cleanup --output "trinity_$1"
