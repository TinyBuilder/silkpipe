#!/usr/bin/env python3
import sys
import json
from pathlib import Path

sra = sys.argv[1]
dir = Path(sra)
blast_output = {} 

with open(dir/'nr_matches.json') as file:
    blast_output = json.load(file)

print(blast_output) 
