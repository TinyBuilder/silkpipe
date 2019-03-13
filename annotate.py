#!/usr/bin/env python3
import sys
import json
from pathlib import Path
from Bio import SeqIO

sra = sys.argv[1]
dir = Path(sra)
blast_output = {} 

with open(dir/'nr_matches.json') as file:
    blast_output = json.load(file)

nucleotides = []
for rec in SeqIO.parse(dir/'extended.fa', 'fasta'):
    nucleotides.append(rec)
        
peptides = [] 
for rec in SeqIO.parse(dir/'extended_prots.fa', 'fasta'):
    peptides.append(rec)

print(blast_output)