#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import pathlib
import argparse

parser = argparse.ArgumentParser(description='Need PYTHON 3 version with packages numpy, pandas, biopython install with :pip install biopython; pip install numpy; pip install pandas; Ex. command line :  python3 Pipeline_euk_v2.py -fna fasta_test -mt tx_sp_mod_nods.txt -k krak.test -t Mucoromycota -o test ')
parser.add_argument('-f', '--file', type=str, help='parsed webpage\n')
args = parser.parse_args()

d={'protId':None, 'clade':None, 'spe':None, 'acc':None}
l=1
allLine=[]

print(args.file)
# 
with open(args.file , 'r') as i:
    with open(args.file+'.out' , 'w') as o:
        for line in i :
            if l == 1 :
                d['protId'] =line.split('>')[1].split('<')[0]
                o.write(d['protId']+'\t')
            elif l==2 :
                d['clade'] =line.split('>')[1].split('<')[0]
                o.write(d['clade']+'\t')
                d['spe'] =line.split('>')[2].strip()
                o.write(d['spe']+'\t')
            elif l==3 :
                d['acc'] =line.split('[')[1].split(']')[0]
                o.write(d['acc']+'\n')
                allLine.append(d)
                l=0
            l+=1
            # print(d)
            
print(allLine)