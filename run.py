#!/usr/bin/env python3
import subprocess
import sys

remote = sys.argv[1]
with open('new_species.csv') as file:
    for line in file:
        accession = line.rsplit(sep=',', maxsplit=1)[1]
        subprocess.run(['./run.sh', remote, accession])
