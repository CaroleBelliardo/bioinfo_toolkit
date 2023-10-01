#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=18G   # memory per Nodes
#SBATCH -J "addCol"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

db_lineage=/bighub/hub/DB/ncbi_taxo/al_taxonomy_lineage.txt
awk '{ FS = OFS = "\t" } NR==FNR {h[$1] = $2 ; next} {print $0,h[$3]}' $db_lineage all_classf.krak-split-${SLURM_ARRAY_TASK_ID} > all_classf.krak-split-${SLURM_ARRAY_TASK_ID}.lineage
