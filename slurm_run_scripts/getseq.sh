#!/bin/bash

# Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # Number of processor cores (i.e., tasks)
#SBATCH --cpus-per-task=10     # Number of CPU per task (adjust as needed)
#SBATCH --nodes=1   # Number of nodes
#SBATCH --mem=124G   # Memory per node (adjust as needed)
#SBATCH -J "getseq"   # Job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # Email address for job notifications
#SBATCH --mail-type=ALL   # Email notification type
#SBATCH --gid=bioinfo   # Group ID
#SBATCH -e slurm-%j.err   # Error log file
#SBATCH -o slurm-%j.out   # Output log file
#SBATCH -p all   # Specify the job queue/partition

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

# Set the paths to required variables
bash_scriptsP=$1/bin_cbelliardo/
script=extractListofSeq_perl
SING_IMG="/database/hub/SINGULARITY_GALAXY//MetagTools_kraken_blast_diamond_hmmer.sif"
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

# Prepare to process multiple files
cd $2

# Get a list of files with the specified extension
FILES=($(ls -1 *$3 | cut -d'.' -f1 ))
F=${FILES[$SLURM_ARRAY_TASK_ID]}

# Define input and output paths
l=$4 # List of files (one file per line)
f=$5/${F}.$4 # Input file path
o=$6 # Output directory path

# Execute the Singularity container command with specified parameters
$SING2 $SING_IMG ${bash_scriptsP}/${script} -l $l -f $f -o $o

# Document how to run the script
echo "To run this script, use the following command:"
echo "getseq.sh <wd_path> <repo_seq_path> <extension_str> <list_path> <repo_fasta> <repo_output>"

