#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=240G   # memory per Nodes   #38
#SBATCH -J "search"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-search-%j.err
#SBATCH -o slurm-search-%j.out
#SBATCH -p treed

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/mmseqs2:14.7e284--pl5321hf1761c0_1'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd '/kwak/hub/25_cbelliardo/MISTIC/Salade_I/metabarcoding'
db='/database/hub/SILVA/silva'

i=$1
o=$2
tmp =${o}_tmp
$SING2 $SING_IMG mmseqs easy-search $i $db $o $tmp --threads $SLURM_JOB_CPUS_PER_NODE --min-seq-id 0.97 --cov-mode 2 --cov 0.97 --search-type 3 

# RUN WITH: sbatch mmseq_search_silva.sh <input:file> <output:file>