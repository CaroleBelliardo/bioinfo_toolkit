#!/usr/bin/env python
# coding: utf-8

"""
process_fasta_files.py

Usage:
  process_fasta_files.py <correspondence_file> <output_dir> <fasta_dir>

Options:
  -h --help     Show this help message and exit.
  <correspondence_file>   File containing taxid-fasta file correspondence.
  <output_dir>            Output directory for modified fasta files.
  <fasta_dir>             Directory containing fasta files.

"""

from docopt import docopt
from Bio import SeqIO
import pandas as pd
import os

def process_fasta_files(correspondence_file, output_dir, fasta_dir):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(output_dir + " created successfully.")
    else:
        print("The directory "+ output_dir +" already exists.")
        exit(0)

    # Read the correspondence file
    correspondence = pd.read_csv(correspondence_file, sep='\t', names=["species","taxid"])

    # Iterate through fasta files
    for fasta_file in os.listdir(fasta_dir):
        if fasta_file.endswith(".fa"):
            species = fasta_file.split('.')[0]
            taxid = correspondence.loc[correspondence['species'] == species, 'taxid'].values[0]

            records = []
            # Add taxid to the description of each sequence in the fasta file
            for seq_record in SeqIO.parse(os.path.join(fasta_dir, fasta_file), "fasta"):
                seq_record.description += f" TaxID={taxid}"
                records.append(seq_record)

            # Write modified sequences to a new fasta file
            output_file = os.path.join(output_dir, fasta_file)
            SeqIO.write(records, output_file, "fasta")

if __name__ == '__main__':
    arguments = docopt(__doc__)
    correspondence_file = arguments['<correspondence_file>']
    output_dir = arguments['<output_dir>']
    fasta_dir = arguments['<fasta_dir>']
    process_fasta_files(correspondence_file, output_dir, fasta_dir)
