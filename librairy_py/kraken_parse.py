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
