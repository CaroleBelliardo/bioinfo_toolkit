#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "vsearch"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/vsearch.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"


$SING2 $SING_IMG vsearch --cluster_size $1 --id 0.99 --uc ${1}.uc --centroids ${1}.centroid 
#--sizein --maxseqlength 100000 --threads 1 --strand both



