#!/usr/bin/env python3

"""
Script to extract protein ID (protID) and TaxID from a FASTA file and generate a tab-separated output file.

Usage:
    extract_ids.py <input_fasta> <output_file>

Arguments:
    input_fasta     Path to the input FASTA file.
    output_file     Path to the output tab-separated file.

Example:
    ./extract_ids.py input.fasta output.tsv
"""

import argparse

def extract_protID_taxID(sequence):
    """
    Extract protID and TaxID from a sequence header.

    Args:
        sequence (str): Sequence header.

    Returns:
        tuple: (protID, TaxID)
    """
    s = sequence.split()
    protID = s[0]
    if 'UniRef90_' in protID:
        protID = protID[10:]
    TaxID = [el for el in sequence.strip().split() if el.startswith('TaxID=')][0].strip('TaxID=')
    return protID, TaxID

def main(input_file, output_file):
    """
    Main function to process the input FASTA file and generate the output file.

    Args:
        input_file (str): Path to the input FASTA file.
        output_file (str): Path to the output tab-separated file.
    """
    with open(input_file, 'r') as input_handle, open(output_file, 'w') as output_handle:
        output_handle.write(f"accession.version\ttaxid\n")  # Output header
        for line in input_handle:
            line = line.strip()
            if line.startswith(">"):
                protID, TaxID = extract_protID_taxID(line)
                output_handle.write(f"{protID}\t{TaxID}\n")

if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("input_fasta", help="Path to the input FASTA file.")
    parser.add_argument("output_file", help="Path to the output tab-separated file.")
    args = parser.parse_args()

    # Call the main function with provided arguments
    main(args.input_fasta, args.output_file)
