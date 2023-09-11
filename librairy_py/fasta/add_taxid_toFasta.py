"""Format FASTA file with TaxID information.

Usage:
  format_fasta.py <taxid_file> <fasta_file> <output_file>

Arguments:
  <taxid_file>    Path to the taxid file.
  <fasta_file>    Path to the input FASTA file.
  <output_file>   Path to the output formatted FASTA file.

Options:
  -h --help       Show this help message and exit.
"""

import argparse

def read_taxid_file(taxid_file):
    """Read taxid file and create a dictionary."""
    dico = {}
    with open(taxid_file, 'r') as d:
        for line in d:
            line = line.strip().split('\t')
            if len(line) == 3:
                dico[line[1]] = line[2]
            else:
                dico[line[1]] = '0'
    return dico

def format_fasta(taxid_dict, fasta_file, output_file):
    """Format the FASTA file with TaxID information."""
    with open(fasta_file, 'r') as fasta, open(output_file, 'w') as o:
        for line in fasta:
            if line.startswith('>'):
                line = line.strip()
                query = line.lstrip('>')
                taxid = taxid_dict.get(query, '0')
                o.write(f"{line} TaxID={taxid}\n")
            else:
                o.write(line)

def main():
    args = docopt(__doc__)

    taxid_file = args['<taxid_file>']
    fasta_file = args['<fasta_file>']
    output_file = args['<output_file>']

    taxid_dict = read_taxid_file(taxid_file)
    format_fasta(taxid_dict, fasta_file, output_file)

if __name__ == '__main__':
    main()
