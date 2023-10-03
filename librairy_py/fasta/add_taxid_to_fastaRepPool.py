#!/usr/bin/env python
# coding: utf-8

"""
process_fasta_files.py

Usage:
  process_fasta_files.py <correspondence_file> <output_dir> <fasta_dir> [--threads=<n>]

Options:
  -h --help     Show this help message and exit.
  --threads=<n>  Number of threads to use for parallel processing [default: 2].
  <correspondence_file>   File containing taxid-fasta file correspondence.
  <output_dir>            Output directory for modified fasta files.
  <fasta_dir>             Directory containing fasta files.

"""

from docopt import docopt
from Bio import SeqIO
import pandas as pd
import os
from concurrent.futures import ThreadPoolExecutor

def process_fasta_file(fasta_file, correspondence, output_dir):
    species = fasta_file.split('.')[0]
    taxid = correspondence.loc[correspondence['species'] == species, 'taxid'].values[0]

    records = []
    for seq_record in SeqIO.parse(os.path.join(fasta_dir, fasta_file), "fasta"):
        seq_record.description += f" TaxID={taxid}"
        records.append(seq_record)

    output_file = os.path.join(output_dir, fasta_file)
    SeqIO.write(records, output_file, "fasta")

def process_fasta_files(correspondence_file, output_dir, fasta_dir, num_threads):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(output_dir + " created successfully.")
    else:
        print("The directory "+ output_dir +" already exists.")
        exit(0)

    correspondence = pd.read_csv(correspondence_file, sep='\t', names=["species","taxid"])
    fasta_files = [f for f in os.listdir(fasta_dir) if f.endswith(".fa")]

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        executor.map(lambda f: process_fasta_file(f, correspondence, output_dir), fasta_files)

if __name__ == '__main__':
    arguments = docopt(__doc__)
    correspondence_file = arguments['<correspondence_file>']
    output_dir = arguments['<output_dir>']
    fasta_dir = arguments['<fasta_dir>']
    num_threads = int(arguments['--threads'])
    process_fasta_files(correspondence_file, output_dir, fasta_dir, num_threads)

In this version, I've added an optional argument --threads=<n> to specify the number of threads to use for parallel processing (default is 2). The process_fasta_file function now takes a fasta file name, the correspondence DataFrame, and the output directory as arguments. The main process_fasta_files function reads the correspondence file, identifies fasta files, and then uses a ThreadPoolExecutor to process the files in parallel.

You can run this script with the --threads=<n> argument to control the number of threads used for parallel processing. Keep in mind that the optimal number of threads may vary depending on your specific system and workload.
