#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os       # manip systeme
import sys      # gestion arguments et opt

total=0
dist=0
nodis=0

lenMin=int(sys.argv[2])
gMin=int(sys.argv[3])

#os.system("cut -f 13 "+inFile+" > "+inFile+"_s" )  
with open(sys.argv[1]+'_'+sys.argv[2]+'l'+sys.argv[3]+'g', 'a') as file:
	with open(sys.argv[1]) as f:
		for line in f:
			total=total+1
			line=line.rstrip()    # supprime les sauts de lignes
			l=line.split("\t") 
			if int(l[1]) >= lenMin or int(l[2]) >= gMin :
				file.writelines(line+'\n')
				dist=dist+1
			else:
				nodis=nodis+1
	f.close()
file.close()

print('taille seq min : '+sys.argv[2]+', nb gene min :'+sys.argv[3]) 
print('total '+str(total))
print('retenu '+str(dist))
print('noret '+str(nodis))

