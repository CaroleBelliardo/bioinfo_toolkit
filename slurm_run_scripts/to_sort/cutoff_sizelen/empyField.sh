#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "noZero"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


#while read file
 # do
  #  cat ${DIR}/${LIST}/${file}/${file}.a.fna.size >> ${DIR}/${LIST}_${SLURM_ARRAY_TASK_ID}_20191219.len
  #done < ${DIR}/${LIST}.list_${SLURM_ARRAY_TASK_ID}

#echo ${DIR}/${LIST}_${SLURM_ARRAY_TASK_ID}_20191219.len

awk 'BEGIN { FS = OFS = "\t" } { for(i=1; i<=NF; i++) if($i ~ /^ *$/) $i = 0 }; 1'  $1 > ${1}_zero
