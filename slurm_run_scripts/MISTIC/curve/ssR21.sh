#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=2     # number of CPU per task ## /selon seff output
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   ## /selon seff output
#SBATCH -J "subsampR21"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-sspR21-%j.err
#SBATCH -o slurm-sspR21-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/rasusa:0.7.1--hec16e2b_1'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw '

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve/illumina/pool/"

illumina_reads_R1="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R1.fastq.gz"
illumina_reads_R2="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R2.fastq.gz"

out='subsampling1'
$SING2 $SING_IMG rasusa -s100 -n 142266744 -i $illumina_reads_R1 -o ${out}/illumina_reads_R2_0.1.fasta -O g
