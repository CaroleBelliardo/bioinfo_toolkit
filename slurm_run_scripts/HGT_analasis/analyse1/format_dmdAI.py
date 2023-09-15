#!/usr/bin/env python
# coding: utf-8

import numpy as np
import pandas as pd 
import sys

file = sys.argv[1]
out= file+'_formated'

query = 'None'
with open(file, 'r') as f: 
    with open(file, 'w') as o: 
        for line in f : 
            line = line.strip()
            line = line.split('\t')
            if line[0].startswith('>') : 
                query = line[0].lstrip('>')
            else : 
                line = [query] + line
                if line[15] != 'exclude' :
                    line='\t'.join(line[0:13])
                    o.write(line)
