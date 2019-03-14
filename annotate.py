#!/usr/bin/env python3
import sys
import json
from pathlib import Path
from Bio import SeqIO

sra = sys.argv[1]
dir = Path(sra)
blast_output = []

# Read BLAST results.
with open(dir/'nr_matches.json') as file:
    blast_output = json.load(file)['BlastOutput2']

# Read nucleotide sequences.
nucleotides = {}
for rec in SeqIO.parse(dir/'extended.fa', 'fasta'):
    nucleotides[rec.id] = rec.seq

# Read peptide sequences.
peptides = {}
for rec in SeqIO.parse(dir/'extended_prots.fa', 'fasta'):
    peptides[rec.id] = rec.seq

# Define acceptable types.
silk_types = ['AMPULLATE', 'FLAGELLIFORM',
              'TUBULIFORM', 'ACINIFORM', 'PYRIFORM', 'AGGREGATE']
silk_subtypes = ['MAJOR', 'MINOR']

# Prepare buckets.
uncharacterised = []
masp1 = []
masp2 = []
minor = []
flagelliform = []
tubuliform = []
aciniform = []
pyriform = []
aggregate = []
other = []


# Annotator function
def annotate(result):
    title = result['query_title']
    n_seq = nucleotides[title]
    p_seq = peptides[title]
    tag_count = {}

    # Results packer function
    def pack(annotation):
        return {'title': title, 'n_seq': n_seq, 'p_seq': p_seq, 'annotation': annotation}

    # If no hits say it's uncharacterised
    if len(result['hits']) == 0:
        uncharacterised.append(pack('UNCHARACTERISED'))
        return

    # Go through each hit to extract possible descriptions.
    for hit in result['hits']:
        tags = hit['description']['title'].upper().split()
        for tag in tags:
            tag2 = None
            if tag == 'EGG':
                tag = 'TUBULIFORM'

            if tag == 'MASP' or tag == 'DRAGLINE':
                tag = 'AMPULLATE'
                tag2 = 'MAJOR'

            if tag in tag_count:
                tag_count[tag] += 1
            else:
                tag_count[tag] = 1

            if not tag2 == None:
                if tag2 in tag_count:
                    tag_count[tag2] += 1
                else:
                    tag_count[tag2] = 1

    # Sort the tags from the most common to least.
    tag_sorted = {k: v for k, v in sorted(
        tag_count.items(), key=lambda tuple: tuple[1])}

    # Identify tags that say it's silk.
    silk_type = None
    silk_subtype = None
    silk_number = None
    for tag in tag_sorted.keys():
        if silk_type == None and tag in silk_types:
            silk_type = tag
        elif silk_subtype == None and tag in silk_subtypes:
            silk_subtype = tag
        elif silk_number == None:
            try:
                silk_number = str(int(tag))
            except ValueError:
                continue

    # Default annotation is most common tag.
    annotation = tag_sorted.keys()[0]

    # Check if silk.
    if silk_type == 'AMPULLATE':
        annotation = ' '.join([silk_subtype, silk_type, silk_number])
        annotation = 'PREDICTED ' + annotation + '-LIKE'
        if silk_subtype == 'MINOR':
            minor.append(pack(annotation))
            return

        if silk_number == '1':
            masp1.append(pack(annotation))
            return

        if silk_number == '2':
            masp2.append(pack(annotation))
            return

    elif not silk_type == None:
        annotation = silk_type
        annotation = 'PREDICTED ' + annotation + '-LIKE'
        if silk_type == 'FLAGELLIFORM':
            flagelliform.append(pack(annotation))
            return

        if silk_type == 'TUBULIFORM':
            tubuliform.append(pack(annotation))
            return

        if silk_type == 'ACINIFORM':
            aciniform.append(pack(annotation))
            return

        if silk_type == 'PYRIFORM':
            pyriform.append(pack(annotation))
            return

        if silk_type == 'AGGREGATE':
            aggregate.append(pack(annotation))
            return

    annotation = 'PREDICTED ' + annotation + '-LIKE'
    other.append(pack(annotation))
    return


[annotate(report['report']['results']) for report in blast_output]

# Print out to files.
with open(dir/'uncharacterised.json', 'a+') as file:
    print(json.dumps(uncharacterised), file=file)

with open(dir/'masp1.json', 'a+') as file:
    print(json.dumps(masp1), file=file)

with open(dir/'masp2.json', 'a+') as file:
    print(json.dumps(masp2), file=file)

with open(dir/'minor_ampullate.json', 'a+') as file:
    print(json.dumps(minor), file=file)

with open(dir/'flagelliform.json', 'a+') as file:
    print(json.dumps(flagelliform), file=file)

with open(dir/'tubuliform.json', 'a+') as file:
    print(json.dumps(tubuliform), file=file)

with open(dir/'aciniform.json', 'a+') as file:
    print(json.dumps(aciniform), file=file)

with open(dir/'pyriform.json', 'a+') as file:
    print(json.dumps(pyriform), file=file)

with open(dir/'aggregate.json', 'a+') as file:
    print(json.dumps(aggregate), file=file)

with open(dir/'others.json', 'a+') as file:
    print(json.dumps(other), file=file)
