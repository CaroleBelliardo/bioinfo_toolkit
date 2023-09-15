import pandas as pd

def import_hmm_result_into_df (hmm_output_path) : 

    colonnes = ['target', 'accessionT','query', 'accessionQ', "E-value_fullSeq",
                'score_fullSeq', 'biais_fullSeq', "E-value_bestDom",'score_bestDom', 'biais_bestDom']

    df = pd.read_csv( hmm_output_path, comment='#',delim_whitespace=True, header=None, names = colonnes, usecols=range(10))
    return df 
