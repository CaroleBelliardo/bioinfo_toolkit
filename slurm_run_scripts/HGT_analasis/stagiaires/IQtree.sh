#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "iqtree"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-align-%j.err
#SBATCH -o slurm-align-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
p='/database/hub/SINGULARITY_GALAXY'
iqtree='iqtree:2.2.2.7--h7ff8a90_0'
SING_IMG=$p'/'$iqtree
SING2='singularity exec --bind /kwak/hub:/kwak/hub'


#Run a search in blastp mode
cd /kwak/hub/ST_workspace/25_ST23_aricci/0_data/hgt/listProt/listProt_header/fasta/fasta_eventLR/alignements

FILES=($(ls -1 *.fasta.fa))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.fasta.fa | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG iqtree -s $FILENAME -m TEST -mset WAG,LG,JTT -bb 1000 -alrt 1000 -nt AUTO > tree/$FILENAME
