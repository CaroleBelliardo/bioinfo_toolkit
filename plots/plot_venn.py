"""
Usage: plot_venn.py [-h] [-f FORMAT] [-o OUTPUT] [-e EXTENSION]

Plot venn diagram for all files ending with '_lr' in the current directory.

Options:
  -h, --help            show this help message and exit
  -f FORMAT, --format=FORMAT
                        format of the output file (pdf or png) [default: pdf]
  -o OUTPUT, --output=OUTPUT
                        name of the output file [default: venn]
  -e EXTENSION, --extension=EXTENSION  [default: _list]
"""
import pandas as pd
from venny4py.venny4py import *
import glob
from docopt import docopt

if __name__ == '__main__':
    # parse arguments
    args = docopt(__doc__)
    format = args['--format']
    output = args['--output']
    ext = args['--extension']

    # import all file ending by '_lr' in current directory
    files = glob.glob('*' + ext)

    # create a list of dataframe and keep file name as index
    dfs = {}
    for file in files:
        dfs[file] = set(pd.read_csv(file, sep='\t', header=None)[0].tolist())

    # plot venn diagram
    venny4py(dfs, names=files, filename=f'{output}.{format}', figsize=(4,4), dpi=300)