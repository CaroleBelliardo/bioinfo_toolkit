#!/usr/bin/env python
# coding: utf-8
import sys
import numpy as np
import pandas as pd

out = pd.read_table('/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/8_parcoursTree/analyse/data_branchCompo.csv_formated_lineages',  sep ='\t')
out.rename({'protid': 'gene'}, axis = 1 , inplace = True)
out.loc[out.tag.isna(),'tag'] = out.loc[out.tag.isna(),'tag'].fillna('no')

def common_elements(list1, list2):
    result = []
    for element in list1:
        if element in list2:
            result.append(element)
    return result

def found_lca (liste_esp) :
    list1 = liste_esp.pop()
    while (len(liste_esp) > 0): 
        list2 = liste_esp.pop()
        list1 = common_elements(list1, list2)
    return list1

def compute_prop(table, branche_label):
    serie = 100/(len(table.tag)/table.groupby('tag').size())
    serie = serie.to_dict()

    tags = ['E', 'S', 'H', 'U', 'T', 'no'] # maj values
    for i in tags :
        if i not in serie : 
            serie[i] = 0

    return serie

def compute_prop2(table, branche_label):
    serie = 100/(len(table.tag)/table.groupby('taxonType').size())
    serie = serie.to_dict()

    tags = ['Bacteria', 'Eukaryota', 'Viridiplantae', 'Fungi', 'Viruses', 'Archaea'] # maj values
    for i in tags :
        if i not in serie : 
            serie[i] = 0

    return serie


def lca_donor(table, branche_label, logFile) :
    global found_lca
    with open(logFile,'a') as log : 
        nb = table.loc[:, 'nb'].values[0]
        gene = table.loc[out.type == 'ppn','gene'].values[0]
        log.write('start :' + nb + ' '+ gene +'\n')
        
        table = table.loc[table.tag != 'U']
        ## -- tag
        sb_compo = compute_prop(table, branche_label)
        
        if ('no' in sb_compo) and (sb_compo['no'] == 100) : 
            log.write('\t-no branch '+branche_label+' '+ nb +' '+ gene +'\n')
            sb_lca, sb_lca_cl, sb_compo_TH , sb_label = 'None', 'None',[], 'no '+branche_label
        
        elif (sb_compo['E'] + sb_compo['S'] > 50 ) :
            log.write('\t-More 50% Tylenchida :'+ nb +' '+ gene +'\n')
            sb_lca, sb_lca_cl, sb_compo_TH , sb_label = 'Tylenchina', 'Tylenchina', sb_compo, 'to check'
        
        else : 
            subtable = table.loc[table.tag.isin(['H','T'])]
            tmp2 = compute_prop(subtable, branche_label)
            
            if (tmp2['T'] > tmp2['H']) : 
                log.write('\t-no HGT :'+ nb +' '+ gene +'\n')
                
                s =  subtable.loc[subtable.tag == 'T']
                liste = [l.replace('; ', ';').replace(' ;', ';').lstrip(';').rstrip(';').rstrip(';').rstrip(' ').split(';') for l in s.loc[:, 'lineage_complete'].unique() ]
                l = found_lca(liste)
                cl = '; '.join(l)
                node = l[-1]
                
                log.write('\t-no HGT :' + nb +' '+ gene+ ' ' +node+'\n')
                sb_label = 'no HGT'
                
                
            else : 
                ssubtable = subtable.loc[subtable.tag.isin(['H'])]
                tmp3 = compute_prop2(ssubtable, branche_label)
                ll = [key for key, value in tmp3.items() if value == max(tmp3.values())]
                
                s =  subtable.loc[subtable.taxonType == ll[0]]
                liste = [l.replace('; ', ';').replace(' ;', ';').lstrip(';').rstrip(';').rstrip(';').rstrip(' ').split(';') for l in s.loc[:, 'lineage_complete'].unique() ]
                l = found_lca(liste)
                cl = '; '.join(l)
                node = l[-1]
                
                log.write('\t-HGT :' + nb +' '+ gene+ ' ' +node+'\n')
                sb_label = 'HGT'
            sb_lca, sb_lca_cl, sb_compo_TH  = node, cl, tmp2
                
        
    return sb_lca, sb_lca_cl,  sb_compo, sb_compo_TH , sb_label 

df = pd.DataFrame({'nb': [], 
                   'ppn__lca': [], 
                   'ppn__node': [], 
                   'pnn_prot__nb': [], 
                   'ppn_esp__nb': [], 
                   'ppn__source': [], 
                   'sb_lca': [], 
                   'sb_lca_cl': [], 
                   'sb_compo': [], 
                   'sb_compo_TH': [], 
                   'sb_label': [], 
                   'sb_prot__nb': [], 
                   'sb_esp__nb': [], 
                   'sb__source': [], 
                   'sba_lca': [], 
                   'sba_lca_cl': [], 
                   'sba_compo': [], 
                   'sba_compo_TH': [], 
                   'sba_label': [], 
                   'sba_prot__nb': [], 
                   'sba_esp__nb': [], 
                   'sba__source': []})


for e in out.nb.unique() :
    oute = out.loc[out.nb == e]
    ppn_liste = [l.replace('; ', ';').replace(' ;', ';').lstrip(';').rstrip(';').rstrip(';').rstrip(' ').split(
        ';') for l in oute.loc[oute.type == 'ppn', 'lineage_complete'].unique() if ('Tylenchina' in l)]
    l = found_lca(ppn_liste)
    cl = '; '.join(l)
    ppn__node = l[-1]
    ppn__lca = l[-1]
    pnn_prot__nb = len(oute.loc[oute.type == 'ppn', 'gene'])
    ppn_esp__nb = len(oute.loc[oute.type == 'ppn', 'sp'].unique())
    ppn__source = oute.loc[oute.type == 'ppn',
                           ].groupby('source').size().to_dict()

    sb_lca, sb_lca_cl,  sb_compo, sb_compo_TH, sb_label = lca_donor(
        oute, 'SB', '/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/8_parcoursTree/analyse/log_lcaDonorsSB.txt')
    sb_prot__nb = len(oute.loc[oute.type == 'SB', 'gene'])
    sb_esp__nb = len(oute.loc[oute.type == 'SB', 'lineage_complete'].unique())
    sb__source = oute.loc[oute.type == 'SB',
                          ].groupby('source').size().to_dict()

    sba_lca, sba_lca_cl,  sba_compo, sba_compo_TH , sba_label = lca_donor(oute, 'ASB', '/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/8_parcoursTree/analyse/log_lcaDonorsASB.txt')
    sba_prot__nb = len(oute.loc[oute.type == 'ASB', 'gene'])
    sba_esp__nb = len(oute.loc[oute.type == 'ASB',
                      'lineage_complete'].unique())
    sba__source = oute.loc[oute.type == 'ASB',
                           ].groupby('source').size().to_dict()


    df2 = {'nb': e, 
           'ppn__lca': ppn__lca, 
           'ppn__node': ppn__node, 
           'pnn_prot__nb': pnn_prot__nb, 
           'ppn_esp__nb': ppn_esp__nb, 
           'ppn__source': ppn__source, 
           'sb_lca': sb_lca, 
           'sb_lca_cl': sb_lca_cl, 
           'sb_compo': sb_compo, 
           'sb_compo_TH': sb_compo_TH, 
           'sb_label': sb_label, 
           'sb_prot__nb': sb_prot__nb, 
           'sb_esp__nb': sb_esp__nb, 
           'sb__source': sb__source, 
           'sba_lca': sba_lca,
           'sba_lca_cl' : sba_lca_cl, 
           'sba_compo' : sba_compo, 
           'sba_compo_TH' : sba_compo_TH, 
           'sba_label' :sba_label, 
           'sba_prot__nb': sba_prot__nb,
           'sba_esp__nb': sba_esp__nb,
           'sba__source': sba__source}
    
    df = df.append(df2, ignore_index=True)

df.to_csv('/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/8_parcoursTree/analyse/data_branchCompo.csv_formated_lineages_analyse.txt', sep ='\t', index = False)

