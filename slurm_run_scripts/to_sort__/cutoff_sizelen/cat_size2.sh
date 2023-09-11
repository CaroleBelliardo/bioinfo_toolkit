#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "cat2"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/home/singularity/images/MapTools.sif
#BUILD= # out

#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"
LIST=$1
DIR=$2



while read file
  do
    cat ${DIR}/${file}/${file}.a.fna.size >> ${DIR}/../data1_len_${SLURM_ARRAY_TASK_ID}.txt
  done < ${LIST}_${SLURM_ARRAY_TASK_ID}

echo ${DIR}/../data1_len_${SLURM_ARRAY_TASK_ID}.txt
