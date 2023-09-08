#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import pathlib
from modules import gestError
from modules import parse
import multiprocessing as mp

#run augustus
def augustus(lofl): ## ajouter singularity avec variable sing et sing2
    model,fastaN, gffPath=lofl
    if pathlib.Path(fastaN+'.fna').exists ():
        if model != 'none' :
            str1 = " augustus --uniqueGeneId=true --gff3=on --species="+model+" "+fastaN+".fna  > "+gffPath
            content = os.popen(str1).read()


# dev!! a verifier
def augustusLoop2(dt):   #fastaRepo,dico_contigTaxon,fastaOutRepo
    job_list = []
    for species in dt.index.to_list():
        t_list = [species,dt.fnaPath[species],dt.gffPath[species]]
        job_list.append(t_list)
    parse.parrallelize(augustus,job_list)
# def augustusLoop2(dt):   #fastaRepo,dico_contigTaxon,fastaOutRepo      #metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
#     job_list = []
#     for species in dt.index.to_list():
#         r=dt.fnaPath[species]+'_split'
#         if os.path.exists(r): # fichier > 1 G => 1esp: len(l) jobs
#             l=os.listdir(R)
#             for f_split in l:
#                 t_list = [species,dt.fnaPath[species].str+'/'+l,dt.gffPath[species].str+'/'+l]
#                 job_list.append(t_list)
#         else: # fichier < 1 G => 1esp: 1 job                
#             t_list = [species,dt.fnaPath[species],dt.gffPath[species]]
#             job_list.append(t_list)
# 
#     parse.parrallelize(augustus,job_list)

def addH(f,i): # add metagid in fasta header
    str1 = "./addH.sh "+f+' '+i
    content = os.popen(str1).read()

#run diamond

def diamond(l): ## ajouter singularity avec variable sing et sing2
    aa,dmd=l
    db='/bighub/hub/DB/NR_2020_01_diamond.dmnd'   
    if pathlib.Path(db).exists ():
    # db='/work/cbelliardo/db/NR_2020_01_diamond.dmnd'
        str1 = " diamond blastp -p 70   -e 0.000001 --outfmt 102 -d "+db+" -q "+ aa+" -o " + dmd
        content = os.popen(str1).read()
    
#appel diamond 
#filtre diamond
#appel busco

##end dev ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
