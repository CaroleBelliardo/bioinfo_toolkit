#!/bin/bash

# Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes
#SBATCH -J "len"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all
#SBATCH -e /work/cbelliardo/slurms/slurm-%j.err
#SBATCH -o /work/cbelliardo/slurms/slurm-%j.out

# Define variables for paths
input_directory="$1"
file_list="$2"
output_directory="$3"

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

##-- compress all files in the input directory
cd "$input_directory"
FILES=($(cat "$file_list"))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

/work/cbelliardo/bin/seqLen -p "$output_directory" -f "$FILENAME" -e '.a.fna' -o 'fna_size'

# Call sbatch to execute this script with array job
# Usage: sbatch --array=0-650 len_fasta_list.sh '<input_directory>' '<file_list>' '<output_directory>'
# Example: sbatch --array=0-650 len_fasta_list.sh '/lerins/hub/DB/Metagenomics/rawData/JGI_IMGVR' '/lerins/hub/DB/Metagenomics/rawData/Mgnify' '<output_directory>'

## run
# sbatch --array=0-<nb of file in input_directory> len_fasta_list.sh '<input_directory>' '<file_list>' '<output_directory>'
