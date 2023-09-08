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
cd /kwak/hub/ST_workspace/25_ST23_aricci/0_data/NEW_TREES/alignements/alignement_ori
FILES=($(ls -1 *.fa))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.fa | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

ali_ori=$FILENAME
newseq=/kwak/hub/ST_workspace/25_ST23_aricci/0_data/NEW_TREES/alignements/LG.fasta/$PREF.fasta
new_ali=/kwak/hub/ST_workspace/25_ST23_aricci/0_data/NEW_TREES/alignements/alignement_new/$PREF.fa
muscle1=/kwak/hub/ST_workspace/25_ST23_aricci/0_data/NEW_TREES/alignements/LG.align1_muscle/$PREF.aln
muscle2=/kwak/hub/ST_workspace/25_ST23_aricci/0_data/NEW_TREES/alignements/LG.align2_muscle/$PREF.aln
$SING2 $muscle muscle -in $newseq -out $muscle1
$SING2 $muscle muscle -profile -in1 $ali_ori -in2 $muscle1 -out $muscle2
