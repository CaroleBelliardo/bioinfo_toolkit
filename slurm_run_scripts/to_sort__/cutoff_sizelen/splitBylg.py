#!/usr/bin/python3
# -*- coding: utf-8 -*-

##--- Header
import pprint   # debugg -- affichage Dump des structures de données
import os       # manip systeme
import sys      # gestion arguments et opt

dis_11=0
dis_12=0
dis_13=0

dis_21=0
dis_22=0
dis_23=0

dis_31=0
dis_32=0
dis_33=0


with open(sys.argv[1]) as f:
	for line in f:
		line=line.rstrip()    # supprime les sauts de lignes
		l=line.split("\t") 
			
		if int(l[1]) >= 500 or int(l[2]) >= 1:
			with open(sys.argv[1]+'_31', 'a') as file:			
				file.writelines(line+'\n')
			file.close()
			dis_31=dis_31+1
			
			if int(l[1]) >= 500 or int(l[2]) >= 2:
				with open(sys.argv[1]+'_32', 'a') as file:			
					file.writelines(line+'\n')
				file.close()
				dis_32=dis_32+1
				
				if int(l[2]) >= 3: #int(l[1]) >= 500 or 
					with open(sys.argv[1]+'_33', 'a') as file:			
						file.writelines(line+'\n')
					file.close()
					dis_33=dis_33+1
				
			if int(l[1]) >= 750 or int(l[2]) >= 1:
				with open(sys.argv[1]+'_21', 'a') as file:			
					file.writelines(line+'\n')
					file.close()
					dis_21=dis_21+1
				
				if int(l[1]) >= 750 or int(l[2]) >= 2:
					with open(sys.argv[1]+'_22', 'a') as file:			
						file.writelines(line+'\n')
					file.close()
					dis_22=dis_22+1
					
					if int(l[1]) >= 750 or int(l[2]) >= 3:
						with open(sys.argv[1]+'_23', 'a') as file:			
							file.writelines(line+'\n')
						file.close()
						dis_23=dis_23+1

			if int(l[1]) >= 1000 or int(l[2]) >= 1:
				with open(sys.argv[1]+'_11', 'a') as file:			
					file.writelines(line+'\n')
					file.close()
					dis_11=dis_11+1
				
				if int(l[1]) >= 1000 or int(l[2]) >= 2:
					with open(sys.argv[1]+'_12', 'a') as file:			
						file.writelines(line+'\n')
					file.close()
					dis_12=dis_12+1
					
					if int(l[1]) >= 1000 or int(l[2]) >= 3:
						with open(sys.argv[1]+'_13', 'a') as file:			
							file.writelines(line+'\n')
						file.close()
						dis_13=dis_13+1


with open(sys.argv[1]+'_summary', 'a') as file:			
	file.writelines(dis_11+'\n')
	file.writelines(dis_12+'\n')
	file.writelines(dis_13+'\n')

	file.writelines(dis_21+'\n')
	file.writelines(dis_22+'\n')
	file.writelines(dis_23+'\n')

	file.writelines(dis_31+'\n')
	file.writelines(dis_32+'\n')
	file.writelines(dis_33+'\n')
file.close()

