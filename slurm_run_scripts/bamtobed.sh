#!/bin/bash

# This script is used to convert BAM files to BED format using bedtools.

# Usage: sbatch bamtobed.sh <directory>
# Submit this script with: sbatch bamtobed.sh

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes   #38
#SBATCH -J "bamtobed"   # job name
#SBATCH --mail-type=ALL
#SBATCH -e slurm-bamtobed-%j.err
#SBATCH -o slurm-bamtobed-%j.out
#SBATCH -p all

# Load singularity module
module load singularity/3.5.3

# Set singularity command and image path
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'
SING_IMG="/database/hub/SINGULARITY_GALAXY/metagwgs.sif"

# Change to the specified directory
cd $1

# Get the list of BAM files in the directory
FILES=($(ls -1 *.bam))

# Get the filename of the BAM file to be converted
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

# Get the prefix of the BAM file to be converted
PREFS=($(ls -1 *.bam | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

# Execute the bamtobed command using singularity and save the output to a BED file
$SING2 $SING_IMG bedtools bamtobed -i $bam > $PREF.bed

## run the script with: 
# sbatch --array=0-<number of BAM files> bamtobed.sh <directory>