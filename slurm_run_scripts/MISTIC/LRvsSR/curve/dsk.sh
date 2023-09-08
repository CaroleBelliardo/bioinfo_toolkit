#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=424G   # memory per Nodes   #38
#SBATCH -J "kat"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-kat-%j.err
#SBATCH -o slurm-kat-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='tools/dsk_2.3.3'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw'

cd /kwak/hub/25_cbelliardo/MISTIC/

$SING2 $SING_IMG dsk  -file  Salade_I/curve/HIFI/subsampling1/hifi_reads_1.fasta,Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R1_0.1.fastq,Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R2_0.1.fastq -out dsk_output

