#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=40     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=300G   # memory per Nodes   #38
#SBATCH -J "AvP"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-avp-%j.err
#SBATCH -o slurm-avp-%j.out
#SBATCH -p treed

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

DB=/lerins/hub/DB/Metagenomics/MetaSoil_NR_Eukprot_v2.dmnd 
QUERY=$1
OUT=${1}.dmd

#Run a search in blastp mode
$SING2 $SING_IMG diamond blastp --more-sensitive -k500 -e 0.00001 -p40 --outfmt 6 -b 8 -c 1 -d $DB -q $QUERY -o $OUT
