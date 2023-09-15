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

proteome="/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/formated/filtred_tab.txt"
while read l 
do echo $l; sed -i "s/$(echo $l|cut -f1 -d' ')/$(echo $l | cut -f3 -d' ')/g" $FILENAME 
done < $proteome

echo "$FILENAME ok etape 1"
