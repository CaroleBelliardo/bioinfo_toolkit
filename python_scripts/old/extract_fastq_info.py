"""Extract Read Names and Phred Scores from a FASTQ.gz file.

Usage:
  extract_fastq_info.py -i <input_file> -o <output_file>

Options:
  -i <input_file>    Input FASTQ.gz file.
  -o <output_file>   Output file to store read names and Phred scores.
"""

import gzip
from docopt import docopt

def extract_fastq_info(input_file, output_file):
    # Open the input FASTQ.gz file in read mode with gzip.open
    with gzip.open(input_file, "rt") as infile:
        lines = infile.readlines()

    # Open the output file in write mode
    with open(output_file, "w") as outfile:
        for i in range(0, len(lines), 4):
            # The first column contains the read name
            read_name = lines[i].strip()

            # The fourth line contains the Phred quality scores
            phred_scores = lines[i + 3].strip()

            # Write the read name and Phred scores to the output file
            outfile.write(f"{read_name}\t{phred_scores}\n")

if __name__ == "__main__":
    arguments = docopt(__doc__)

    input_file = arguments["-i"]
    output_file = arguments["-o"]

    extract_fastq_info(input_file, output_file)
