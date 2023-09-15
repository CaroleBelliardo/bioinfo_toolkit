#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "align"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-align-%j.err
#SBATCH -o slurm-align-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
p='/database/hub/SINGULARITY_GALAXY'
mafft='mafft:7.520--hec16e2b_1'
raxml='raxml:8.2.9--hec16e2b_6'

muscle='/kwak/hub/ST_workspace/25_ST23_aricci/tools/singularity/alignments/muscle:5.1--h9f5acd7_1'

SING_IMG=$p'/'$mafft
SING2='singularity exec --bind /kwak/hub:/kwak/hub'


#Run a search in blastp mode
cd /kwak/hub/ST_workspace/25_ST23_aricci/0_data/hgt/listProt/listProt_header/fasta/fasta_eventLR
FILES=($(ls -1 *.fasta))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.fasta | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG mafft --auto --thread 8 $FILENAME >/kwak/hub/ST_workspace/25_ST23_aricci/0_data/hgt/listProt/listProt_header/fasta/fasta_eventLR/alignements/$PREF.fa
