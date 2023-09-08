#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import sys
import numpy as np
from modules import gestError
import multiprocessing as mp
import pandas as pd
import pathlib  # test file
from Bio import SeqIO
import operator
from time import process_time

wd = os.path.dirname(os.path.realpath(__file__))

## -- Parse kraken
def time(func):
    t1_start = process_time()
    func
    t1_stop = process_time()
    print(f'time : {t1_stop - t1_start}')

def progress(iteration, steps, max_value, no_limit=False):
    if int(iteration) == max_value:
        if no_limit == True:
            sys.stdout.write('\r')
            print("[x] \t%d%%" % (100), end='\r')
        else:
            sys.stdout.write('\r')
            print("[x] \t%d%%" % (100))
    elif int(iteration) % steps == 0:
        sys.stdout.write('\r')
        print("[x] \t%d%%" % (float(int(iteration) / int(max_value)) * 100), end='\r')
        sys.stdout.flush()
    else:
        pass


def appendIndicoValue(dico, key, value_list):
    if key in dico:
        dico[key] = dico[key] + value_list
    else:
        dico[key] = value_list
    return dico


def appendSetIndicoValue(dico, key, value_set):
    if key in dico:
        dico[key] = dico[key].union(value_set)
    else:
        dico[key] = value_set
    return dico


def parseLineageIntoList(string):
    liste = list(map(int, (filter(None, string.split(';')))))
    return liste


def parrallelize(func, jobL) :
    pool = mp.Pool(70)
    for i, _ in enumerate(pool.imap_unordered(func, jobL), 1):
        progress(i, 1, len(jobL))

def appendDicoIndicoValue(dico, key,key2, value_set):
    if key in dico:
        if key2 in dico[key]:
            dico[key][key2] = dico[key][key2].union(value_set)
        else:
            dico[key][key2] = value_set
    else:
        dico[key][key2] = value_set
    return dico

def krakenToDico(models_df, krakLineage_df, eukTaxid, tmp):
    """

    @type models_df: dict # contig : model
    """
    # -- all contigsNames with taxid == only 'eukaryote' => print in file; no model could be assign for augustus
    euk = krakLineage_df[krakLineage_df.taxid == eukTaxid]
    euk.to_csv(f'{tmp}/euk_{eukTaxid}.csv', index=False, sep='\t')
    krakLineage_df = krakLineage_df[~(krakLineage_df.taxid == eukTaxid)]  # remove contigsNames == eukaryote

    # -- select left row contain euka taxid
    krakLineage_df = krakLineage_df[krakLineage_df['nodes'].notna()]
    krakLineage_df = krakLineage_df[krakLineage_df['nodes'].str.contains(str(eukTaxid))]

    # -- assignation contigs to Models --
    taxid_kraken = set(krakLineage_df.taxid)
    deeperTx_list = set(models_df.taxid_new_deeperTaxon)

    # step 1:  taxid given by kraken == taxid model species; exact search
    intersect_KM = taxid_kraken.intersection(deeperTx_list)

    model_contigs_dico = {models_df.index[models_df.taxid_new_deeperTaxon == tx].values[0]: set(
        krakLineage_df.seqid[krakLineage_df.taxid == tx].to_list()) for tx in
        intersect_KM}

    # model_contigs_dico = {models_df.index[models_df.taxid_new_deeperTaxon == tx].values[0]: set(
    #     krakLineage_df.seqid[krakLineage_df.taxid == tx]) for tx in intersect_KM}
<<<<<<< HEAD
    # krakLineage_df.seqid[krakLineage_df.taxid == tx].to_list()) for tx in
=======
    # krakLineage_df.seqid[krakLineage_df.taxid == tx].to_list())
    # for tx in
>>>>>>> 860d152d72a53c914c359d9b3ff9b10f4ca4da7a
    # intersect_KM}
    #
    # model_contigs_dico=dict()
    # for tx in intersect_KM:
    #     subTab = krakLineage_df[krakLineage_df.taxid == tx]
    # for m in subTab.metag:
    #     model_contigs_dico[m] = {
    #         models_df.index[models_df.taxid_new_deeperTaxon == tx].values[0]: set(subTab.seqid[subTab.taxid == tx]) for
    #         tx in
    #         intersect_KM}

    left_taxid_kraken = taxid_kraken.difference(intersect_KM)  # MAJ list kraken taxid
    krakLineage_df = krakLineage_df[krakLineage_df.taxid.isin(left_taxid_kraken)]  # MAJ kraken

    del intersect_KM
    # step 2:  for each kraken complet node  == deepertaxon => dico ; search if c == on a model branch
    deepernode_models_dico = {models_df.taxid_new_deeperTaxon[models_df.index == i].values[0]: i for i in
                              models_df.index}

    for n in deepernode_models_dico:

        # subTab = krakLineage_df[krakLineage_df.nodes.str.contains(str(n))]
        # k = models_df.index[models_df.taxid_new_deeperTaxon == n].values[0]

        subTab = krakLineage_df.seqid[krakLineage_df.nodes.str.contains(str(n))]
        if len(subTab) != 0:

            # for m in subTab[subTab.taxid == tx].metag:
            #     new_contigs_set = set(krakLineage_df.seqid[krakLineage_df.nodes.str.contains(str(n))])
            #     new_contigs_set = set(subTab.seqid[subTab.nodes.str.contains(str(n))])
            # model_contigs_dico = appendSetIndicoValue(model_contigs_dico, k, new_contigs_set)  # MAJ dico
            # model_contigs_dico = appendDicoIndicoValue(model_contigs_dico, m, k, new_contigs_set)
            # krakLineage_df = krakLineage_df[
            #     ~((krakLineage_df.metag == m) & (krakLineage_df.seqid.isin(new_contigs_set)))]  # MAJ kraken

            k = models_df.index[models_df.taxid_new_deeperTaxon == n].values[0]
            new_contigs_set = set(krakLineage_df.seqid[krakLineage_df.nodes.str.contains(str(n))])
            model_contigs_dico = appendSetIndicoValue(model_contigs_dico, k, new_contigs_set) # MAJ dico

            krakLineage_df = krakLineage_df[~(krakLineage_df.seqid.isin(new_contigs_set))]  # MAJ kraken
    del deepernode_models_dico

    # step 3:  for each rank of model complete nodes => keep upper node
    # left_taxid_kraken = taxid_kraken.difference(intersect_KM)  # MAJ taxid_from_kraken

    model_txs_dico = {
        i: set(models_df.complet_taxid[models_df.index == i].values[0].rstrip(';').lstrip(';').split(';')[2:]) for
        i in models_df.index}

    # SORT MODEL BY WEIGHT according to number of contig already identified
    tmp = sorted(model_contigs_dico, key=lambda k: len(model_contigs_dico[k]), reverse=True)
    tmp2 = [m for m in model_txs_dico.keys() if m not in tmp]
    Ordered_model_byWeight = [*tmp, *tmp2]
    model_txs_dico = {i: model_txs_dico[i] for i in Ordered_model_byWeight}

    for i in reversed(range(1, max([len(v) for v in model_txs_dico.values()]))):  # max len complet nodes
        # begining
        model_irank = {k: v for k, v in model_txs_dico.items() if len(v) == i}  # select model with taxo == rank


        for k in model_irank.keys():  # Pour chaque model dont taxo == rank => ajoute les contigs dont taxid correspond
            taxid = model_txs_dico[k].pop()  # maj taxo complet dico
            if int(taxid) in left_taxid_kraken:
                left_taxid_kraken.remove(int(taxid))  # MAJ taxid

                new_contigs_set = set(krakLineage_df.seqid[krakLineage_df.taxid == int(taxid)])
                model_contigs_dico = appendSetIndicoValue(model_contigs_dico, k, new_contigs_set)
                krakLineage_df = krakLineage_df[~(krakLineage_df.seqid.isin(new_contigs_set))]  # MAJ kraken
        del model_irank

    # step 4:  for each rank of kraken complet nodes => keep upper node
    nodes_model_dico = {models_df.complet_taxid[models_df.index == i].values[0]:i for # [13:-1]
        i in Ordered_model_byWeight}

    for kraken_compl_nodes in set(krakLineage_df.nodes):  # pour chaque lefted row of kraken
        kraken_compl_node_set=set(kraken_compl_nodes.rstrip(';').lstrip(';').split(';')[2:])
        inter={v:set(k.rstrip(';').lstrip(';').split(';')[2:]).intersection(kraken_compl_node_set) for k,v in nodes_model_dico.items()}
        inter={k:inter[k] for k in sorted(inter, key=lambda k: len(inter[k]), reverse=True)}
        lk=list(inter.keys())
        if len(lk) >0 :
            m=lk[0]
            new_contigs_set = set(krakLineage_df.seqid[krakLineage_df.nodes == kraken_compl_nodes])
            model_contigs_dico = appendSetIndicoValue(model_contigs_dico, m, new_contigs_set)
            krakLineage_df = krakLineage_df[~(krakLineage_df.seqid.isin(new_contigs_set))]  # MAJ kraken

    return (model_contigs_dico)

    ## --- Parse fasta; extract seq
    # ? parralelise + ADD NO MODEL EUKA seq
    # --needs dico from kraken-lineage


# new fasta
import pyfasta

def extractSeq(t_list):
    fastaFile, dico_contigTaxon, fastaRepo, fastaOutRepo, outputfna = t_list
    fasta_sequences = SeqIO.parse(open(fastaRepo + '/' + fastaFile), 'fasta')  # open fasta
    for seq in fasta_sequences:
        for i in dico_contigTaxon.values():
            if seq.id in i:
                modell = list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(i)]
                dp_tx = outputfna.deeper_taxon[modell]
                p = outputfna.fnaPath.loc[outputfna.deeper_taxon == dp_tx]
                # print(list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(seq.id)])
                pp = p.values[0].strip() + '/' + fastaFile + '.fna'
                output_handle = open(pp, "a")
                SeqIO.write([seq], output_handle, "fasta")  # print sequence in the file
                output_handle.close()


def extractSeqRun(fastaRepo, dico_contigTaxon, fastaOutRepo,
                  outPaths):  # metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    print('*******************************')
    gestError.file_exist(fastaRepo)
    fastaFiles = os.listdir(fastaRepo)
    jobL = []
    for fastaFile in fastaFiles:
        print(fastaFile)
        t_list = [fastaFile, dico_contigTaxon, fastaRepo, fastaOutRepo, outPaths]
        jobL.append(t_list)
    parrallelize(extractSeq, jobL)


def concatFile(repo):  # cat repo ; rm tmp file
    if len(os.listdir(repo)) != 0:
        str1 = "cat " + repo + "/* > " + repo + ".fna; rm -r " + repo
    else:
        str1 = "rm -r " + repo
    content = os.popen(str1).read()


def checkFile_split(fichier):
    if os.stat(fichier).st_size == 1000000000:
        print('need to be splited')
        # split_fasta fichier > fichier+'_split'


# Augustus output traitement
# analyse gff
def gfftobed(l):  # conversion en fichier bed
    gffP, BedP, aaP, gffF = l  # ex . : ['test/GFF_krakenEuka-contigs/', 'test/BED_krakenEuka-contigs/', 'test/AA_krakenEuka-contigs/', 'Mammalia.gff']
    filename = gffF.strip('.gff')  # ex: Mammalia
    GffIN = gffP + gffF
    BedOUT = BedP + filename + '.bed'
    str1 = " awk -F'\t' '$3~/^gene/' " + GffIN + " | awk -F'\t' '{print $1,$4,$5,$6,$7,$8,$9,$2,$3}' OFS='\t' > " + BedOUT
    content = os.popen(str1).read()


def gfftofasta(l):  # extraction seq prot
    gffP, BedP, aaP, gffF = l
    filename = gffF.strip('.gff')
    GffIN = gffP + gffF
    FaaOUT = gffP + filename + '.aa'
    FaaOUTmv = aaP + filename + '.aa'
    str1 = "perl " + wd + "/getAnnoFasta.pl " + GffIN
    content = os.popen(str1).read()
    if pathlib.Path(FaaOUT).exists():
        str2 = " mv " + FaaOUT + " " + FaaOUTmv
        content = os.popen(str2).read()
    else:
        print("  -" + FaaOUT + ' doesnt existe!!')


def gffParse2(
        liste):  # fastaRepo,dico_contigTaxon,fastaOutRepo      #metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    # Gff,Bed, Aa=liste
    listeOfgff = os.listdir(liste[0])
    jobL = []
    for f in listeOfgff:
        t_list = liste + [f]
        jobL.append(t_list)
    parrallelize(gfftobed, jobL)
    parrallelize(gfftofasta, jobL)


# parse diamond
def addLineage(f):
    str1 = "sh ./modules/addL.sh" + f
    content = os.popen(str1).read()


def filtreSeq(fastaIn, ContigList, fastaOut):
    fasta_sequences = SeqIO.parse(open(fastaIn), 'fasta')  # open fasta
    for seq in fasta_sequences:
        if seq.id in ContigList:  # if sequence is in list of contig of this taxon for this metag
            SeqIO.write([seq], fastaOut, "fasta")  # print sequence in the file


def dmdParse(l):
    aa, dmdout, aaEuk, = l
    addLineage(dmdout)
    dmdout = dmdout + '.lineage'
    b = pd.read_table(dmdout, sep='\t', names=['pName', 'taxid', 'evalue', 'lineage'])
    b[['contigid', 'protid']] = b.pName.str.split(".", 1, expand=True, )  # split en 2 col
    b['freqContig'] = b.groupby(by='contigid')['contigid'].transform('count')
    b['freqContige'] = b.groupby(['contigid', 'e'])['contigid'].transform('count')
    bb = b.loc[b['e'] == True]
    l_eukContig = bb[bb.freqContige / bb.freqContig > 0.5].pName.to_list()
    filtreSeq(aa, l_eukContig, aaEuk)
    with open(aaEuk + '.list', 'w') as f:
        for item in l_eukContig:
            f.write("%s\n" % item)

    # extract Prodigal seq
    def extProd(p):
        print('ext prod')
        pl = p + '.list'
        print(pl)
        f = open(pl, "r")
        liste = f.readlines()  # list euka contigs
        for i in liste:
            ii = i.rsplit('_', 1)
            contigId, metagId = ii
            ## ou
        # DT=pd.read_table(args.modelTable, sep='\t');
        ##DK[['contig','metagId']] = DK.contig.str.rsplit("_",1,expand=True,)
