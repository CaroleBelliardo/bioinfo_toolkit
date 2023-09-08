## etape 1
# calcul AHS -> besoin de fournir un fichier d'entree = sortie de blast + une colonne : taxid

# = recyclage des fichier tmp de Alienness short_blast_assign avec le script:  
format_dmdAI.py 
# avec le script slurm :
make_dmd.sh 

## calcul ASH avec 
2-ahs_compute2.sh 

# puis run AvP avec feature = ash output, et metag all fasta 
# reformatage fichier fasta db avec 
3-format_metagNR.sh 

#puis run avp avec 
AvP_run_fast_PanGenomeCat75_AI-AHS.sh 
