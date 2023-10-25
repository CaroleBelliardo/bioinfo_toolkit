#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "curve_illumina2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-curve_illumina2-%j.err
#SBATCH -o slurm-curve_illumina2-%j.out
#SBATCH -p infinity

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/kwak/hub/25_cbelliardo/25_MISTIC/tools/seqtk_1.4.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw --bind /lerins/hub:/lerins/hub'

cd "/kwak/hub/25_cbelliardo/25_MISTIC/Salade_I/curve/illumina/fastq_sampling"
illumina_reads_R1="cleaned_Salade_S1_L001_R1.fastq"
illumina_reads_R2="cleaned_Salade_S1_L001_R2.fastq"

out='subsampling2'

$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 51929149  > ${out}/illumina_reads_R1_0.1.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 103858297  > ${out}/illumina_reads_R1_0.2.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 155787446  > ${out}/illumina_reads_R1_0.3.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 207716594  > ${out}/illumina_reads_R1_0.4.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 259645743  > ${out}/illumina_reads_R1_0.5.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 311574892  > ${out}/illumina_reads_R1_0.6.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 363504040  > ${out}/illumina_reads_R1_0.7.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 415433189  > ${out}/illumina_reads_R1_0.8.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 467362337  > ${out}/illumina_reads_R1_0.9.fasta

$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 51929149  > ${out}/illumina_reads_R2_0.1.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 103858297  > ${out}/illumina_reads_R2_0.2.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 155787446  > ${out}/illumina_reads_R2_0.3.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 207716594  > ${out}/illumina_reads_R2_0.4.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 259645743  > ${out}/illumina_reads_R2_0.5.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 311574892  > ${out}/illumina_reads_R2_0.6.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 363504040  > ${out}/illumina_reads_R2_0.7.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 415433189  > ${out}/illumina_reads_R2_0.8.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 467362337  > ${out}/illumina_reads_R2_0.9.fasta

out='subsampling3'

$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 51929149  > ${out}/illumina_reads_R1_0.1.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 103858297  > ${out}/illumina_reads_R1_0.2.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 155787446  > ${out}/illumina_reads_R1_0.3.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 207716594  > ${out}/illumina_reads_R1_0.4.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 259645743  > ${out}/illumina_reads_R1_0.5.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 311574892  > ${out}/illumina_reads_R1_0.6.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 363504040  > ${out}/illumina_reads_R1_0.7.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 415433189  > ${out}/illumina_reads_R1_0.8.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R1 467362337  > ${out}/illumina_reads_R1_0.9.fasta

$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 51929149  > ${out}/illumina_reads_R2_0.1.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 103858297  > ${out}/illumina_reads_R2_0.2.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 155787446  > ${out}/illumina_reads_R2_0.3.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 207716594  > ${out}/illumina_reads_R2_0.4.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 259645743  > ${out}/illumina_reads_R2_0.5.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 311574892  > ${out}/illumina_reads_R2_0.6.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 363504040  > ${out}/illumina_reads_R2_0.7.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 415433189  > ${out}/illumina_reads_R2_0.8.fasta
$SING2 $SING_IMG seqtk sample -s10 $illumina_reads_R2 467362337  > ${out}/illumina_reads_R2_0.9.fasta
