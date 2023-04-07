#!/usr/bin/env python
# coding: utf-8

from Bio import SeqIO
import pandas as pd
import csv
import os

output_files = 'fasta_taxid/'

if not os.path.exists(output_files):
    os.makedirs(output_files)
    print(output_files + " créé avec succès.")
else:
    print("Le répertoire "+ output_files +"existe déjà.")
    exit(0)
    
# Récupération de la liste des fichiers fasta à parcourir
fichiers = os.listdir(".")

# Lire le fichier de correspondance taxid-nom de fichier fasta
corresp_file = "correspondance_namTaxid.tab"

# Récupération de la correspondance taxid/nom de fichier fasta
corresp = pd.read_csv(corresp_file, sep='\t', names = ["species","taxid"])

# Parcours des fichiers fasta
for fichier in fichiers:
    # Vérification que le fichier est bien un fichier fasta
    if fichier.endswith(".fa") :
        sp = fichier.split('.')[0]
        taxid = corresp.loc[corresp['species'] == sp, 'taxid'].values[0]
        
        records = []
        # Ajout du taxid au début du nom de séquence pour chaque séquence du fichier fasta
        for seq_record in SeqIO.parse(fichier, "fasta"):
            #seq_record.id = seq_record.id + " TaxID=" + str(taxid)
            #seq_record.name = seq_record.name + " TaxID=" + str(taxid)
            seq_record.description = seq_record.description + " TaxID=" + str(taxid)
            records.append(seq_record)
            
        # Ecriture des séquences modifiées dans un nouveau fichier fasta
        output_file = os.path.join(output_files, fichier)
        SeqIO.write(records, output_file, "fasta")
