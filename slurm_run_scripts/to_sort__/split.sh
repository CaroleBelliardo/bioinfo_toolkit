#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "busco"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e /work/cbelliardo/zslurm-jobs/slurm-%j.err
#SBATCH -o /work/cbelliardo/zslurm-jobs/slurm-%j.out
#SBATCH -p all

nb=$2
awk ' $0 {a++}{ b=int(a/'"$nb"')+1; print $0 > FILENAME"-split-"b}' $1
