#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "subsampP"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-ssp-tk-%j.err
#SBATCH -o slurm-ssp-tk-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/seqtk_1.4.sif'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw '

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve/illumina/pool/"

illumina_reads_R1="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R1.fastq.gz"
illumina_reads_R2="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R2.fastq.gz"

out='subsampling1'

$SING2 $SING_IMG seqtk sample -s20 $illumina_reads_R1 995867206 > ${out}/seqtk_illumina_reads_R1_0.7.fasta
