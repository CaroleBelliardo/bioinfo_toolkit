#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "tree"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-tree-%j.err
#SBATCH -o slurm-tree-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd /lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/formated

FILES=($(ls -1 *.nexus))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

proteome=/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/0_proteome/0-proteomes.tab_scName__
while read l 
do sed -i "s/$(echo $l|cut -f2 -d' ')/$(echo $l | cut -f3 -d' ')/g" $FILENAME 
done < $proteome

echo "$FILENAME ok etape 1"é

db=/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/pr_taxon_lineage.table__
while read l
do sed -i "s/$(echo $l|cut -f1 -d' ')/$(echo $l | cut -f3 -d' ')/g" $FILENAME
done < $proteome

echo "$FILENAME ok etape 2"
