

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

