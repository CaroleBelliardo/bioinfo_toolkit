"""Extract Read Names and Phred Scores from a FASTQ file.

Usage:
  extract_fastq_info.py -i <input_file> -o <output_file>

Options:
  -i <input_file>    Input FASTQ file (supports .fastq, .fastq.gz, or .fastq.zip).
  -o <output_file>   Output file to store read names and Phred scores.
"""

import gzip
import zipfile
from docopt import docopt
from pathlib import Path

def extract_fastq_info(input_file, output_file):
    file_extension = Path(input_file).suffix.lower()

    if file_extension == ".fastq":
        # Open the input FASTQ file in read mode
        with open(input_file, "r") as infile:
            lines = infile.readlines()
    elif file_extension == ".fastq.gz":
        # Open the input FASTQ.gz file in read mode with gzip.open
        with gzip.open(input_file, "rt") as infile:
            lines = infile.readlines()
    elif file_extension == ".fastq.zip":
        # Open the input FASTQ.zip file and extract its contents
        with zipfile.ZipFile(input_file, "r") as zip_file:
            # Assuming there's only one file in the zip archive
            file_in_zip = zip_file.namelist()[0]
            with zip_file.open(file_in_zip, "r") as infile:
                lines = infile.readlines()
    else:
        raise ValueError(f"Unsupported file extension: {file_extension}")

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
