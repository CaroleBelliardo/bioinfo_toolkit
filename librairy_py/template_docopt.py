#!/usr/bin/env python
# coding: utf-8

"""
  Usage:
    readLen.py -b <FILE> -l <REPO>

  Options:
    -b, --bed <FILE>   gene list
    -l, --lenRepo <REPO>    tree repositoy
"""


import csv
import os
import sys
import pandas as pd
from docopt import docopt



def main():
    args = docopt(__doc__)
    print('ok')

if __name__=='__main__':
   main()
