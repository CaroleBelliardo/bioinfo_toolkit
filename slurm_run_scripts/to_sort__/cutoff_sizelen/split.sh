#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=26     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=248G   # memory per Nodes
#SBATCH -J "split"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/diamond_0.9.29.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"

#p=/work/cbelliardo/4-seuil_cut-Metag/Faa_1000l-3g
#r=${p}/${1}_${SLURM_ARRAY_TASK_ID}

f=$1
awk ' $0~">" {a++}{ b=int(a/3500000)+1; print $0 > "split22/"FILENAME"-split-"b}' $f # fastafile découpe
