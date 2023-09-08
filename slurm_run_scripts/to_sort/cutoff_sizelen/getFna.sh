#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=248G   # memory per Nodes
#SBATCH -J "getF"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
id=${SLURM_ARRAY_TASK_ID}
dataSet=$1

DIR=/work/cbelliardo/4-seuil_cut-Metag
FAA=${DIR}/1-data
OUT=${DIR}/Faa_1000l-3g

mkdir ${OUT}/$dataSet
while read mgL
  do
    mgI=${FAA}/${dataSet}/${mgL}/${mgL}.a.faa
    mgO=${OUT}/${dataSet}/${mgL}
    mkdir $mgO
    perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' ${DIR}/$2 ${mgI} > ${mgO}/${mgL}.a.fa
  done < ${FAA}/${1}.list_${id}
