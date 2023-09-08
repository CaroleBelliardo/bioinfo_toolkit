#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=124G   # memory per Nodes
#SBATCH -J "splitBylg_short"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#path=$1
#len_min=$2
#nb_gene_min=$3

python3 /work/cbelliardo/4-seuil_cut-Metag/splitBylg_short.py ${1}_${SLURM_ARRAY_TASK_ID}_zero $2 $3
