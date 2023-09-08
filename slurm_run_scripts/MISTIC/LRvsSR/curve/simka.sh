#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=424G   # memory per Nodes   #38
#SBATCH -J "simka"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-simka-%j.err
#SBATCH -o slurm-simka-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/simka_1.5.3'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw'

cd /kwak/hub/25_cbelliardo/25_MISTIC/Salade_I/curve/pool

input='simka_tab.txt'
out_tmp='simka_pool_tmp'
out='simka_pool'

$SING2 $SING_IMG simka -in $input -out-tmp $out_tmp -out $out -keep-tmp -data-info -simple-dist -nb-cores 60 -max-memory 4240
