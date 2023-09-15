#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=12     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=248G   # memory per Nodes
#SBATCH -J "plotL"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/Trinity_2.4.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"

LIST=$1
DIR=$2
out=$3


$SING2 $SING_IMG Rscript --vanilla /work/cbelliardo/4-seuil_cut-Metag/OUT_DISTRIB/R_analyses/Plots_len.R /work/cbelliardo/4-seuil_cut-Metag/OUT_DISTRIB/TEST_len_catEnd.txt /work/cbelliardo/4-seuil_cut-Metag/OUT_DISTRIB/TEST_len_catEnd_sum work/cbelliardo/4-seuil_cut-Metag/OUT_DISTRIB/
