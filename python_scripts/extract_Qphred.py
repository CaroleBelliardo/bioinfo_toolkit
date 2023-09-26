"""Extract Read Names and Phred Scores from a FASTQ file using Biopython.

Usage:
  extract_fastq_info.py -i <input_file> -o <output_file>

Options:
  -i <input_file>    Input FASTQ file (supports .fastq, .fastq.gz, or .fastq.zip).
  -o <output_file>   Output file to store read names and Phred scores.
"""

import gzip
import numpy
import zipfile
from docopt import docopt
from pathlib import Path
from Bio import SeqIO

def extract_fastq_qphred(input_file, output_file):
    file_extension = Path(input_file).suffix.lower()

    if (file_extension != ".fastq") and (file_extension != ".fastq.gz") :
        raise ValueError(f"Unsupported file extension: {file_extension}")

    else: 
    # Open the output file in write mode
        with open(output_file, "w") as outfile:
            with open(input_file, "r") as handle:
                for record in SeqIO.parse(handle, "fastq"):
	    # Extract the read name and Phred scores from the Biopython record
                    read_name = record.id
                    phred_scores = record.letter_annotations["phred_quality"]
	    # Convert Phred scores to a string
                    phred_scores_str = " ".join(map(str, phred_scores))
                    print(read_name,numpy.average(phred_scores))
	    # Write the read name and Phred scores to the output file
	        #outfile.write(f"{read_name}\t{phred_scores_str}\n")

if __name__ == "__main__":
    arguments = docopt(__doc__)

    input_file = arguments["-i"]
    output_file = arguments["-o"]

    extract_fastq_qphred(input_file, output_file)
