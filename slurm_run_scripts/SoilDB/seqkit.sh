#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "seqkit"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-sk-%j.err
#SBATCH -o slurm-sk-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
sing_path='/database/hub/SINGULARITY_GALAXY/'
SING_IMG=$sing_path'seqkit-2.5.0--h9ee0642_0.sif'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /database/hub:/database/hub:rw'

cd /database/hub/Metagenomics/MetaSoil_NR_Eukprot_v4

map="MetaSoil_NR_Eukprot_v4.fasta.taxo"
fasta='MetaSoil_NR_Eukprot_v4.fasta'

$SING2 $SING_IMG seqkit rmdup $fasta > ${fasta}.nodup
