#!/usr/bin/env python3
import subprocess

with open('pre-run.csv') as file:
    for line in file:
        accession = line.rsplit(sep=',', maxsplit=1)[1].strip()
        subprocess.run(['./run_local.sh', accession])
