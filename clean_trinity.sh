#!/bin/bash
bbduk.sh in="$1_1.fastq" in2="$1_2.fastq" out="$1_rna.fa" ref=illumina_adapters.fna qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 tpe tbo 
translate6frames.sh in="$1_rna.fa"  out="$1_prot.fa"
