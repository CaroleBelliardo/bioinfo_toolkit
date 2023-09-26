#!/usr/bin/env python
"""
Calculate Qphred scores for sequences in a FASTQ file and save them to an output file.

Usage:
    calculate_qphred.py <input_file> <output_file>
    calculate_qphred.py (-h | --help)

Options:
    -h --help        Show this help message and exit.

Arguments:
    <input_file>     Input FASTQ file (plain or gzipped).
    <output_file>    Output file to save read names and Qphred scores.
"""

from docopt import docopt
from fastq_module import *

def main(input_file, output_file):
    records = read_fastq(input_file)
    qphred_scores = calculate_qphred_scores(records)
    write_qphred_scores(records, output_file)
    num_sequences, phred_min, phred_max, phred_median, phred_mean = calculate_statistics(qphred_scores)
    sequence_lengths = [len(record.seq) for record in records]
    generate_pdf_report("output_stats.pdf", num_sequences, phred_min, phred_max, phred_median, phred_mean, sequence_lengths, qphred_scores)

if __name__ == "__main__":
    arguments = docopt(__doc__)
    input_file = arguments["<input_file>"]
    output_file = arguments["<output_file>"]
    main(input_file, output_file)

