#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes   #38
#SBATCH -J "rank"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-ash-%j.err
#SBATCH -o slurm-ash-%j.out
#SBATCH -p all



cd '/lerins/hub/DB/Metagenomics/MetaSoil_NR_Eukprot_v9_taxo/IMGM_split/ranks'
FILES=($(ls -1 *))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}


#taxid_ranks='/lerins/hub/DB/TAXONOMY/online/nodes.dmp_cut15'
#awk -v FS='\t' -v OFS='\t' 'NR==FNR {h[$1] = $2; next} {print $0,h[$3]}' $taxid_ranks $FILENAME > ranks/$FILENAME
cut -f 4 $FILENAME > cut4/$FILENAME
sort cut4/$FILENAME | uniq -c  > cut4/${FILENAME}_suc
