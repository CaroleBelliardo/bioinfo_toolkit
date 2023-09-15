def blast_outfmt6_to_df(chemin_fichier_blast):
    """
    Charge les résultats d'une recherche BLAST au format 6 dans un DataFrame.

    :param chemin_fichier_blast: Le chemin vers le fichier de résultats BLAST au format 6.
    :return: Un DataFrame contenant les résultats du BLAST.
    """
    # Définir les noms des colonnes pour le DataFrame
    colonnes = ["query_id", "subject_id", "pct_identity", "alignment_length",
                "mismatches", "gap_openings", "query_start", "query_end",
                "subject_start", "subject_end", "e_value", "bit_score"]

    # Charger le fichier BLAST dans un DataFrame en utilisant les colonnes définies
    dataframe_blast = pd.read_csv(chemin_fichier_blast, sep='\t', header=None, names=colonnes)

    return dataframe_blast
