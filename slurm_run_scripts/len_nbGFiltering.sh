#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes
#SBATCH -J "f"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all
#SBATCH -e /work/cbelliardo/slurms/slurm-%j.err
#SBATCH -o /work/cbelliardo/slurms/slurm-%j.out


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

##--len
cd $1

FILES=($(ls -1 *.$2))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

#/work/cbelliardo/bin_cbelliardo/seqLen -f $FILENAME -o $3

## run
# sbatch len_nbGFiltering.sh <wd_path> <repo> <output> 


