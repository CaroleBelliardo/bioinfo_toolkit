#!/usr/bin/python3
# -*- coding: utf-8 -*-
import pathlib  # test file
import os
import sys
from modules import parse
import pandas as pd

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)


def mkdir_exist(repoP):  # creation repertoire
    if not os.path.exists(repoP):
        os.makedirs(repoP)
    #     print(repoP+' was created')
    # else :
    #     print(repoP+' already exit')   


def file_exist(filepath):  # test if file existe
    fileP = pathlib.Path(filepath)
    if not fileP.exists():
        sys.exit("Error message:\n\n!!! " + filepath + "file not exist !!!\n\n")
    return (fileP)


def file_exit(filepath, func):  # test if file existe
    fileP = pathlib.Path(filepath)
    if fileP.exists():
        print('  !! ' + filepath + ' ok')
        r = func(filepath)
    else:
        sys.exit("Error message:    \n\n!!! " + filepath + "file not exist !!!\n\n")
    return (r)


def nonEuk(kkOutput_df):
    if pathlib.Path('kraken_nonEuka.csv').exists():  # delete already non euka indentified and listed
        notEuk = pd.read_table('kraken_nonEuka.csv', names=['contigs'])
        kkOutput_df = kkOutput_df[~kkOutput_df.seqid.isin(notEuk.contigs.tolist())]
    return (kkOutput_df)


def krakenTodicoTempo(Models_df, KkOutput_df, lineage, eukTaxid, defaultModel):
    if pathlib.Path("tempoFiles/krakenModels.txt").exists():  # skip kraken parse
        print('  **tempoFiles/krakenModels already exist')
        pd_contigTaxon = pd.read_csv("tempoFiles/krakenModels.txt", sep='\t', index_col=0)
        Dico_contigTaxon = pd_contigTaxon.contigs.to_dict()  # => dico contig:deeper_taxon
        Dico_contigTaxon = {i: list(filter(None, Dico_contigTaxon[i].split(';'))) for i in Dico_contigTaxon}
        # for i in Dico_contigTaxon: Dico_contigTaxon[i]= list(filter(None,Dico_contigTaxon[i].split(';')))

    else:
        print('  **tempoFiles/krakenModels.txt needs to be created')
        Dico_contigTaxon = parse.krakentoDico(Models_df, KkOutput_df, lineage, eukTaxid, defaultModel)
        with open('tempoFiles/krakenModels.txt', 'a') as file:  # save intermediate file for next< run
            file.write('model\tcontigs')
            for m in Dico_contigTaxon:
                file.write('\n' + m + '\t')
                for i in Dico_contigTaxon[m]:
                    file.write(i + ';')

        print('---krakenModels was created')
    return (Dico_contigTaxon)
