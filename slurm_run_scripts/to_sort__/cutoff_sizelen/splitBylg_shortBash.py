#!/usr/bin/python3
# -*- coding: utf-8 -*-

##--- Header
import pprint   # debugg -- affichage Dump des structures de données
import os       # manip systeme
import sys      # gestion arguments et opt

dist=0
nodis=0
with open(sys.argv[1]) as f:
	for line in f:
		line=line.rstrip()    # supprime les sauts de lignes
		l=line.split("\t") 
		if int(l[1]) >= 1000 or int(l[2]) >= 3:
			os.system("echo "+line+' > '+sys.argv[1]+'_13_shortBash' )
			dist=dist+1
		else :
			nodis=nodis+1
print(dist)
print(nodis)

