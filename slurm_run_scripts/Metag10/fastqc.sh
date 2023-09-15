#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "fastqc"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mg-%j.err
#SBATCH -o slurm-mg-%j.out
#SBATCH -p all

module load singularity/3.5.3


### MAIN -------------------------------------------------

SING_IMG='/database/hub/SINGULARITY_GALAXY/fastqc:0.11.9--hdfd78af_1'
SING2='singularity exec --bind /kwak/hub:/kwak/hub'

cd '/kwak/hub/25_cbelliardo/MetaNema_LRmg/10Metag/fastq' 
FILES=($(ls -1 *.fastq))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG fastqc -i $FILENAME --outdir fastqc -f fastq -t 8 --contaminants pacbio_vectors_db.fa  # -a


