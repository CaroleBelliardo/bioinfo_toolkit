#!/usr/bin/env python3

#"""
#	Usage:
#		tmp.py --fasta <FILE> --taxid <FILE> --output <FILE>
#
#	Options:
#		-f, --fasta <FILE>    fasta file input
#		-t, --taxid <FILE>    tabulare file seqId:taxId
#		-o, --output <FILE>    filsta file output
#	
#"""

import sys
import pandas as pd
from Bio import SeqIO
#from docopt import docopt

def nrFormat(fasta, taxid_tab, output):
    taxid = pd.read_csv(taxid_tab, sep='\t', names=['id','id2', 'taxid'], dtype='str')
    taxid = taxid.drop('id2', axis=1)
    taxid = taxid.set_index('id')
    taxid_dict = taxid.loc[:, 'taxid'].to_dict()

    with open(fasta) as originalFile, open(output, 'w') as formatedFile:
        ff = SeqIO.parse(originalFile, 'fasta')

        for seq_record in ff:
            if seq_record.id in taxid_dict:
                id = seq_record.id
                seq_record.description = 'TaxID=' + taxid_dict[id]

            SeqIO.write(seq_record, formatedFile, 'fasta')


def main():
#    args = docopt(__doc__)
#    f=args['--fasta']
#    print(f)
    f=sys.argv[1]
    t=sys.argv[2]
    o=sys.argv[3]

    nrFormat(f, t, o)

if __name__ == "__main__" :
    main()


