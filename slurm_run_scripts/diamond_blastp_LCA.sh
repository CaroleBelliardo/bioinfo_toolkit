#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=464G   # memory per Nodes   #38
#SBATCH -J "dmd2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/diamond:2.1.7--h5b5514e_0'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /database/hub:/database/hub'


#Run a search in blastp mode
cd $1

QUERY=$2
db=$3
OUT=$4$SING2 $SING_IMG diamond blastp --ultra-sensitive --threads $SLURM_JOB_CPUS_PER_NODE --outfmt 102 -d $db --query $QUERY --out $OUT 

## run
# sbatch diamond_blastp.sh <wd_path> <query_fastaFile_path> <db_path> <outputFile_path> 
