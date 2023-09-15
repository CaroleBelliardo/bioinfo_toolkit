"""Convert a FASTQ file to FASTA format.

Usage:
  fastq_to_fasta.py <input_file> <output_file>

Arguments:
  <input_file>   Input FASTQ file.
  <output_file>  Output FASTA file.

Options:
  -h --help      Show this help message and exit.

"""

import sys
import gzip
import doctopt

def convert_fastq_to_fasta(input_file, output_file):
    """Convert a FASTQ file to FASTA format.

    Args:
        input_file (str): Path to the input FASTQ file.
        output_file (str): Path to the output FASTA file.

    Returns:
        None
    """
    try:
        if input_file.endswith('.gz'):
            fastq = gzip.open(input_file, 'rt')
        else:
            fastq = open(input_file, 'r')

        line_n = 0
        line_buffer = 0
        line_id = 1
        outfile = open(output_file, 'w')
        fastas = 1
        fasta_length = 0

        for line in fastq:
            line_n += 1

            if line_n == 10000:
                line_buffer += 10000
                line_n = 0
                print(f'Processed lines: {line_buffer}')

            if line_id == 4:
                line_id = 1
            elif line_id == 3:
                line_id += 1
            elif line_id == 2:
                line_id += 1
                fasta_line = line
                fasta_length += len(fasta_line.strip())
                outfile.write(fasta_line)
                fastas += 1
            else:
                if '@' not in line:
                    print('Are you sure this is a FASTQ file?')
                else:
                    line_id += 1
                    fname = input_file.split('__')[0]
                    fasta_header = line.lstrip('@').replace('/', '_')
                    fasta_header = f'>{fname}__{fasta_header.strip()}\n'
                    outfile.write(fasta_header)

        outfile.close()
        print(f'FASTA records written: {fastas}, average length of fasta sequences: {float(fasta_length // fastas)}')

    except Exception as e:
        print(f'An error occurred: {e}')

if __name__ == '__main__':
    arguments = doctopt.docopt(__doc__)
    convert_fastq_to_fasta(arguments['<input_file>'], arguments['<output_file>'])
