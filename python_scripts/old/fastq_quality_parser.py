"""Extract Read Names and Phred Scores from a FASTQ file.

Usage:
  extract_fastq_info.py -i <input_file> -o <output_file>

Options:
  -i <input_file>    Input FASTQ file (supports .fastq, .fastq.gz, or .fastq.zip).
  -o <output_file>   Output file to store read names and Phred scores.
"""

import sys
import gzip
from Bio import SeqIO
from docopt import docopt

def calculate_qphred(input_file, output_file):
    try:
        if input_file.endswith(".gz"):
            # Open the input file as a gzipped FASTQ file
            with gzip.open(input_file, "rt") as handle:
                records = SeqIO.parse(handle, "fastq")
        else:
            # Open the input file as a plain FASTQ file
            with open(input_file, "r") as handle:
                records = SeqIO.parse(handle, "fastq")

        with open(output_file, "w") as out_handle:
            for record in records:
                read_name = record.id
                qphred = sum(record.letter_annotations["phred_quality"]) / len(record)
                out_handle.write(f"{read_name}\t{qphred}\n")

        print(f"Qphred scores calculated and saved to {output_file}")

    except Exception as e:
        sys.stderr.write(f"Error: {str(e)}\n")
        sys.exit(1)

if __name__ == "__main__":
    arguments = docopt(__doc__)
    input_file = arguments["<input_file>"]
    output_file = arguments["<output_file>"]
    calculate_qphred(input_file, output_file)
