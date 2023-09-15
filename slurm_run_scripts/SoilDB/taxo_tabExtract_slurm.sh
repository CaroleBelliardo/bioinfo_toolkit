#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=3     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=16G   # memory per Nodes   #38
#SBATCH -J "taxo_DB"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-taxoDB-%j.err
#SBATCH -o slurm-taxoDB-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3


SING_IMG='/kwak/hub/25_cbelliardo/tools/singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub'

cd "/database/hub/Metagenomics/MetaSoil_NR_Eukprot_v4/"
db="MetaSoil_NR_Eukprot_v4.fasta"

$SING2 $SING_IMG python taxo_tabExtract.py $db nr_mgSR_mgLR_wormabase__tags_taxo.tab
