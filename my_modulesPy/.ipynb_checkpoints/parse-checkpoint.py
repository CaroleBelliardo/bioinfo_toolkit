#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import sys
from modules import gestError
from modules import callTools
import multiprocessing as mp
import pandas as pd
import pathlib # test file
from Bio import SeqIO
import operator

wd=os.path.dirname(os.path.realpath(__file__))

## --- Parse kraken
def progress(iteration, steps, max_value, no_limit=False):
     if int(iteration) == max_value:
         if no_limit == True:
             sys.stdout.write('\r')
             print ("[x] \t%d%%" % (100), end='\r')
         else:
             sys.stdout.write('\r')
             print ("[x] \t%d%%" % (100))
     elif int(iteration) % steps == 0:
         sys.stdout.write('\r')
         print ("[x] \t%d%%" % (float(int(iteration) / int(max_value)) *100), end='\r')
         sys.stdout.flush()
     else:
         pass

def appendIndicoValue(dico,key,value_list):
    if key in dico :
        dico[key]=dico[key]+value_list
    else :
        dico[key]=value_list
    return(dico)

def parseLineageIntoList(string):
    liste=list(map(int,(filter(None, string.split(';'))))) 
    return(liste)

def parrallelize(func,jobL):   
    pool=mp.Pool(70)
    for i, _ in enumerate(pool.imap_unordered(func,jobL),1):
        progress(i,1,len(jobL))  
 

def unclassFilter(kkOutput_df):
    if not pathlib.Path('kraken_unclassifed.csv').exists ():
        Ku=kkOutput_df[kkOutput_df.classe == 'U']
        Ku.seqid.to_csv('kraken_unclassifed.csv', index=False, header = False)
    kkOutput_df=kkOutput_df[kkOutput_df.classe == 'C'];print('step4 : U vs C ')
    return(kkOutput_df)

def noModel_parse(Models_df,kraken,AlLineage_df,TaxidEukContig_dico,DefaultModel):
    print('---nomodel parse')
    for c in TaxidEukContig_dico['tmp']:
        tmp_dico={}
        txidK=kraken.taxid[kraken.seqid == c ].values[0]
        txid_list= parseLineageIntoList(AlLineage_df.completTaxid[AlLineage_df.taxid == txidK].values[0])
        for Mid in Models_df.complet_taxid : # pour model
            tree_deepness=len(txid_list)
            for txid in reversed(txid_list):# pour chaque tx id du contig
                l=list(tmp_dico.keys())
                if len(l) > 0:  
                    if tree_deepness < l[-1] :
                        continue
                mid=parseLineageIntoList(Mid) #mid.remove(131567); mid.remove(2759)
                if txid in mid :
                    model=Models_df.index[Models_df.complet_taxid== Mid].values[0]
                    tmp_dico=appendIndicoValue(tmp_dico,tree_deepness,[model])
                    break
                tree_deepness=tree_deepness-1
    #-- sort models same deepness
        if len(tmp_dico) ==0 :# if len = 0 model par defaut =DefaultModel
            model = DefaultModel
        else:
            nodes=sorted(tmp_dico.keys(),reverse=True)
            if nodes[0] < 4:
                appendIndicoValue(TaxidEukContig_dico,DefaultModel,[c])
            else :
                bias_sp=None
                for node in nodes :
                    if bias_sp != None :
                        break
                    else:
                        tmp={}
                        for i in tmp_dico[node]:
                            if i in TaxidEukContig_dico.keys():
                                nb_c=len(TaxidEukContig_dico[i])
                                tmp[i]=nb_c
                            else:
                                print('NOT in taxEukContigDico')
                        if len(tmp) != 0:
                            bias_sp=max(tmp.items(), key=operator.itemgetter(1))[0]
                if bias_sp == None:
                    bias_sp=tmp_dico[nodes[0]][0]
                appendIndicoValue(TaxidEukContig_dico,bias_sp,[c]) # [] = liste
                
        print('\nContig noModel:', c, 'ok')    
    del TaxidEukContig_dico['tmp']
    print('step7: 2/2 kraken parse ok\n##--- All models found in second round:')
    for k in TaxidEukContig_dico.keys() :   
        print('  -', k, ' : ',len(TaxidEukContig_dico[k]))
    print('#--')
    return(TaxidEukContig_dico)


def krakentoDico(models_df,kkOutput_df,lineage,eukTaxid,defaultModel):
    alLineage_df=pd.read_table(lineage, sep='\t',names=['taxid','completLineage','completTaxid']);print('step5 : ok import '+lineage)
    alLineage_df=alLineage_df[alLineage_df.taxid.isin(kkOutput_df.taxid)]
    taxidEukContig_dico={}
    deeperTx_list=models_df.taxid_new_deeperTaxon.to_list()
##-- assignation model - contig in do -- cas simple
    for tx in kkOutput_df.taxid.unique().tolist(): # pour chaque taxon de kraken output
        if (tx == eukTaxid) : # si taxid kraken = euka
            model_associe=defaultModel
        else: # pas juste euka            
            tx_l=alLineage_df.completTaxid[alLineage_df.taxid == tx]
            
            if len(tx_l) == 0 :
                print('\n\ntaxonomic db need to be updated !!\n \t-taxid : '+str(tx) + 'not found !!\n')
                notEuk=open('kraken_taxidToUpdate.csv','a') # save
                l=map(lambda x:x+'\n', kkOutput_df.seqid[kkOutput_df.taxid ==tx].tolist()) # print list line by line
                notEuk.writelines(l)
                notEuk.close()
                kkOutput_df=kkOutput_df[~kkOutput_df.taxid.isin([tx])] # less ram require
                continue
            else:
                t=tx_l.values[0]
                tx_list= parseLineageIntoList(t)
            # -- test si euka    
                if eukTaxid in tx_list :# it's euka
                    if (len(tx_list) < 4):
                        model_associe=defaultModel
                    else :
            # -- deepertax taxid list of complete lineage txid
                        intsecTax=list(set(tx_list).intersection(deeperTx_list))
                        if len(intsecTax) >0 : #
                            model_associe= models_df.index[models_df.taxid_new_deeperTaxon == intsecTax[0] ].values[0]
                        ## -- test    
                            if len(intsecTax) >1 : # test
                                with open('tempoFiles/multimodel.txt' , 'a') as f:
                                    f.write("%s\n" % tx)
                                    for item in intsecTax: f.write("%s\t" % item)
                        else:
                            model_associe='tmp'
                else: # it's not euka
                    notEuk=open('kraken_nonEuka.csv','a') # save
                    l=map(lambda x:x+'\n', kkOutput_df.seqid[kkOutput_df.taxid ==tx].tolist()) # print list line by line
                    notEuk.writelines(l)
                    notEuk.close()
                    kkOutput_df=kkOutput_df[~kkOutput_df.taxid.isin([tx])] # less ram require
                    continue
            
        contig_list=kkOutput_df.seqid[kkOutput_df.taxid ==tx].tolist() # ajout taxon dico euka; taxid: ['contig1','contig2'...],
        taxidEukContig_dico=appendIndicoValue(taxidEukContig_dico,model_associe,contig_list)
    print('step6: 1/2 kraken parse ok\n##--- All models found in first round:')
    for k in taxidEukContig_dico.keys() :   
        print('  -', k, ' : ',len(taxidEukContig_dico[k]))
    print('#--')
##-- assignation model - contig in do -- cas complexe
    kkOutput_df=kkOutput_df[kkOutput_df.seqid.isin(taxidEukContig_dico['tmp'])] # les ram
    alLineage_df=alLineage_df[alLineage_df.taxid.isin(kkOutput_df.taxid)] # less ram
    taxidEukContig_dico=noModel_parse(models_df,kkOutput_df,alLineage_df,taxidEukContig_dico,defaultModel) # reparse les contigs = tmp
    del alLineage_df
    return(taxidEukContig_dico)


## --- Parse fasta; extract seq
#? parralelise + ADD NO MODEL EUKA seq
#--needs dico from kraken-lineage
def extractSeq(t_list):
    fastaFile, dico_contigTaxon,fastaRepo,fastaOutRepo ,outputfna= t_list
    fasta_sequences = SeqIO.parse(open(fastaRepo+'/'+fastaFile),'fasta') # open fasta
    for seq in fasta_sequences:
        for i in dico_contigTaxon.values():
            if seq.id in i : 
                modell=list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(i)]
                dp_tx=outputfna.deeper_taxon[modell]
                p=outputfna.fnaPath.loc[outputfna.deeper_taxon == dp_tx]                
                # print(list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(seq.id)])
                pp=p.values[0].strip()+'/'+fastaFile+'.fna'
                output_handle = open(pp, "a")
                SeqIO.write([seq], output_handle , "fasta") # print sequence in the file
                output_handle.close()

def extractSeqRun(fastaRepo,dico_contigTaxon,fastaOutRepo,outPaths):         #metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    print('*******************************')
    gestError.file_exist(fastaRepo)
    fastaFiles=os.listdir(fastaRepo)
    jobL = []
    for fastaFile in fastaFiles:
        print(fastaFile)
        t_list = [fastaFile,dico_contigTaxon,fastaRepo,fastaOutRepo,outPaths]
        jobL.append(t_list)
    parrallelize(extractSeq,jobL)



def concatFile(repo): # cat repo ; rm tmp file
    if len(os.listdir(repo) ) != 0:
        str1 = "cat "+repo+"/* > "+repo+".fna; rm -r "+repo
    else :
        str1 = "rm -r "+repo
    content = os.popen(str1).read()

def checkFile_split(fichier):
    if os.stat(fichier).st_size == 1000000000:
        print('need to be splited')
        #split_fasta fichier > fichier+'_split'

# Augustus output traitement
#analyse gff
def gfftobed(l):# conversion en fichier bed
    gffP,BedP,aaP, gffF=l # ex . : ['test/GFF_krakenEuka-contigs/', 'test/BED_krakenEuka-contigs/', 'test/AA_krakenEuka-contigs/', 'Mammalia.gff']
    filename=gffF.strip('.gff') # ex: Mammalia
    GffIN=gffP+gffF
    BedOUT=BedP+filename+'.bed'
    str1 = " awk -F'\t' '$3~/^gene/' "+GffIN+" | awk -F'\t' '{print $1,$4,$5,$6,$7,$8,$9,$2,$3}' OFS='\t' > "+BedOUT
    content = os.popen(str1).read()

def gfftofasta(l): # extraction seq prot
    gffP,BedP,aaP, gffF=l
    filename=gffF.strip('.gff')
    GffIN=gffP+gffF
    FaaOUT=gffP+filename+'.aa'
    FaaOUTmv=aaP+filename+'.aa'
    str1 = "perl "+wd+"/getAnnoFasta.pl "+GffIN
    content = os.popen(str1).read()
    if pathlib.Path(FaaOUT).exists ():
        str2 = " mv "+FaaOUT+" "+FaaOUTmv
        content = os.popen(str2).read()
    else :
        print("  -"+FaaOUT+' doesnt existe!!')

def gffParse2(liste):   #fastaRepo,dico_contigTaxon,fastaOutRepo      #metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    # Gff,Bed, Aa=liste
    listeOfgff=os.listdir(liste[0])
    jobL = []
    for f in listeOfgff:
        t_list = liste+[f]
        jobL.append(t_list)
    parrallelize(gfftobed,jobL)
    parrallelize(gfftofasta,jobL)

# parse diamond
def addLineage(f):
    str1 = "sh ./modules/addL.sh"+f
    content = os.popen(str1).read()

def filtreSeq(fastaIn,ContigList,fastaOut):
        fasta_sequences = SeqIO.parse(open(fastaIn),'fasta') # open fasta
        for seq in fasta_sequences:
            if seq.id in ContigList:    # if sequence is in list of contig of this taxon for this metag 
                SeqIO.write([seq], fastaOut, "fasta") # print sequence in the file
                
def dmdParse(l) :
    aa,dmdout,aaEuk,=l
    addLineage(dmdout)
    dmdout=dmdout+'.lineage'
    b=pd.read_table(dmdout, sep='\t',names=['pName', 'taxid','evalue','lineage'])
    b[['contigid','protid']] = b.pName.str.split(".",1,expand=True,) # split en 2 col
    b['freqContig']=b.groupby(by='contigid')['contigid'].transform('count')
    b['freqContige']=b.groupby(['contigid','e'])['contigid'].transform('count')
    bb=b.loc[b['e'] == True]
    l_eukContig=bb[bb.freqContige/bb.freqContig > 0.5].pName.to_list()
    filtreSeq(aa,l_eukContig,aaEuk)
    with open(aaEuk+'.list' , 'w') as f:
        for item in l_eukContig:
            f.write("%s\n" % item)
            
#extract Prodigal seq
    def extProd(p):
        print('ext prod')
        pl=p+'.list'
        print(pl)
        f = open(pl, "r")
        liste=f.readlines() # list euka contigs
        for i in liste :
            ii=i.rsplit('_',1)
            contigId,metagId =ii            
            ## ou 
        # DT=pd.read_table(args.modelTable, sep='\t');
         ##DK[['contig','metagId']] = DK.contig.str.rsplit("_",1,expand=True,)


