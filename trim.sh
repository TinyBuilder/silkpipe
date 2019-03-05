#!/bin/bash
bbduk.sh in="$1/$1_1.fastq" in2="$1/$1_2.fastq" out="$1/trimmed_reads.fq" ref=adapters qtrim=r trimq=10 ktrim=r k=23 mink=11 hdist=1 tpe tbo 
bbduk.sh in="$1/trimmed_reads.fq" out="$1/unbarcoded_reads.fq" barcodes=:
