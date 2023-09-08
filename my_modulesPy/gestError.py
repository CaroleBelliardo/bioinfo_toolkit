#!/usr/bin/python3
# -*- coding: utf-8 -*-
import pathlib  # test file
import os
import sys
from modules import parse
import pandas as pd


def mkdir_exist(repoP):  # creation repertoire
    if not os.path.exists(repoP):
        os.makedirs(repoP)


def file_exist(filepath):  # test if file existe
    file_p = pathlib.Path(filepath)
    if not file_p.exists():
        sys.exit("Error message:\n\n!!! " + filepath + "file not exist !!!\n\n")
    return file_p


def file_exit_func(filepath, func):  # test if file existe
    file_p = pathlib.Path(filepath)
    if file_p.exists():
        print('  !! ' + filepath + ' ok')
        r = func(filepath)
    else:
        sys.exit("Error message:    \n\n!!! " + filepath + "file not exist !!!\n\n")
    return r


def KrakenLineage_exist(kraken_f, lineage_f, tmp_repo):  # -- add lineage to kraken C
    krakenLineage_f = tmp_repo + '/' + os.path.basename(kraken_f) + "_lineage.krak"
    if not pathlib.Path(krakenLineage_f).exists():
        kraken_df = pd.read_table(kraken_f, sep='\t', names=['classe', 'seqid', 'taxid', 'seqLen', 'LCAListe'])
        kraken_df = kraken_df[kraken_df.classe == 'C']
<<<<<<< HEAD
        kraken_df[['seq', 'metag']] = kraken_df.seqid.str.rsplit('_', n=1, expand=True)

=======
        kraken_df[['seqid','metag']]=kraken_df.seqid.str.rsplit('_',n=1,expand=True)
>>>>>>> 860d152d72a53c914c359d9b3ff9b10f4ca4da7a
        lineage_df = pd.read_table(lineage_f, sep='\t', names=['taxid', 'lineage', 'nodes'])

        kraken_lineage = pd.merge(kraken_df, lineage_df, how='left', on='taxid')
        kraken_lineage.to_csv(krakenLineage_f, index=False, sep='\t')
    else:
        kraken_lineage = pd.read_table(krakenLineage_f, sep='\t')
    print(kraken_lineage)
    return kraken_lineage


def krakenModels(kraken_f, lineage_f, tmp_r_str, models_df, eukTaxid_str):
    km_f = tmp_r_str + "/krakenModels.txt"
    if pathlib.Path(km_f).exists():  # skip kraken parse
        m = '  **' + km_f + ' already exist'
        krakenModel_df = pd.read_csv(km_f, sep='\t')
        krakenModel_dico = {i:set(krakenModel_df.contigs[krakenModel_df.model==i].values[0].rstrip(';').lstrip(';').split(';')) for i in krakenModel_df.model}
<<<<<<< HEAD
        # for i in Dico_contigTaxon: Dico_contigTaxon[i]= list(filter(None,Dico_contigTaxon[i].split(';')))
=======
>>>>>>> 860d152d72a53c914c359d9b3ff9b10f4ca4da7a
    else:
        m = '  **' + tmp_r_str + ' created'
        kraken_lineage_df = KrakenLineage_exist(kraken_f, lineage_f, tmp_r_str)
        krakenModel_dico = parse.krakenToDico(models_df, kraken_lineage_df, eukTaxid_str, tmp_r_str)
        del kraken_lineage_df
        with open(km_f, 'a') as file:  # save intermediate file for next< run
            file.write('model\tcontigs')
            for k,v in krakenModel_dico.items():
                file.write('\n' + k + '\t')
                for i in v: file.write(i + ';')
<<<<<<< HEAD

    # return krakenModel_dico, m
=======
    return krakenModel_dico, m
>>>>>>> 860d152d72a53c914c359d9b3ff9b10f4ca4da7a
