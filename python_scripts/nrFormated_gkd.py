#!/usr/bin/env python

from Bio import SeqIO
import sys

d_taxid = {}
with open(sys.argv[2]) as f:
    for line in f:
        line = line.strip()
        (key,val) = line.split()
        d_taxid[key] = val

with open('missingTaxi.fasta', 'a') as mf :
    with open(sys.argv[1]) as handle:
        for record in SeqIO.parse(handle, "fasta"):
            if record.id in d_taxid :
                print(">"+record.id + " TaxID=" + str(d_taxid[record.id]))
                print(record.seq)
            else :
                mf.write(">" + str(record.id) + "\n" + str(record.seq) + "\n")


