#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes
#SBATCH -J "wget"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


FILE=($(cat $2))
line=${FILE[$SLURM_ARRAY_TASK_ID]}

#efetch -format fasta -db sequences -id $line >> seq.fasta2 
wget ${1}/${2}
#wget ${1}$SLURM_ARRAY_TASK_ID.tar.gz
