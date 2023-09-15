#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "AvP"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p treed

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

DB='/lerins/hub/DB/NR/NR_diamond/NR_2020_01_diamond.dmnd'
QUERY=$1
OUT=${1}.dmd

#Run a search in blastp mode
#$SING2 $SING_IMG diamond blastp --more-sensitive -k500 -e 0.00001 -p70 --outfmt 6 -b 8 -c 1 -d $DB -q $QUERY -o $OUT
$SING2 $SING_IMG diamond blastp --top 20 --id 25 -b 8 -c 1 -p 60 --outfmt 102 -d ${DB} -q $QUERY -o $OUT

