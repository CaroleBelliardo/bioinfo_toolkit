#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=696G   # memory per Nodes
#SBATCH -J "tar"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

##-- compress all file of Repo $1
cd $1
FILES=($(ls -1))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

#tar.gz
tar zcvf ${FILENAME}.tar.gz $FILENAME
