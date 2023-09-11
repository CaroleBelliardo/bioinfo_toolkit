try:
    import pandas as pd
    print("Le module pandas est chargé en mémoire.")
except ImportError:
    print("Le module pandas n'est pas installé.")

def read_hmmer_search_tbout(hmmer_output_path):
    """
    import un fichier HMMer search et renvoie les hits dans un dataframe.
    
    Args:
        hmmer_output_path (str): Le chemin du fichier HMMer à importer.
        
    Returns:
        df: Un dataframe.
    """
  
  colonnes = ['target', 'accessionT','query', 'accessionQ', "E-value_fullSeq",
            'score_fullSeq', 'biais_fullSeq', "E-value_bestDom",'score_bestDom', 'biais_bestDom']
  df = pd.read_csv(hmmer_output_path, comment='#',delim_whitespace=True, header=None, names = colonnes, usecols=range(10))
  
  return df
