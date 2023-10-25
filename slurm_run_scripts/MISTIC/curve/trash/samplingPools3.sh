#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=160G   # memory per Nodes   #38
#SBATCH -J "subsampP3"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-ssp3-%j.err
#SBATCH -o slurm-ssp3-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/seqtk_1.4.sif'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw '

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve/illumina/pool/"

illumina_reads_R1="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R1.fastq.gz"
illumina_reads_R2="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R2.fastq.gz"

out='subsampling3'


$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 142266744 > ${out}/illumina_reads_R1_0.1.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 284533487 > ${out}/illumina_reads_R1_0.2.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 426800231 > ${out}/illumina_reads_R1_0.3.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 569066975 > ${out}/illumina_reads_R1_0.4.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 711333719 > ${out}/illumina_reads_R1_0.5.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 853600462 > ${out}/illumina_reads_R1_0.6.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 995867206 > ${out}/illumina_reads_R1_0.7.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 1138133950 > ${out}/illumina_reads_R1_0.8.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R1 1280400693 > ${out}/illumina_reads_R1_0.9.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 142266744 > ${out}/illumina_reads_R2_0.1.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 284533487 > ${out}/illumina_reads_R2_0.2.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 426800231 > ${out}/illumina_reads_R2_0.3.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 569066975 > ${out}/illumina_reads_R2_0.4.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 711333719 > ${out}/illumina_reads_R2_0.5.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 853600462 > ${out}/illumina_reads_R2_0.6.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 995867206 > ${out}/illumina_reads_R2_0.7.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 1138133950 > ${out}/illumina_reads_R2_0.8.fasta
$SING2 $SING_IMG seqtk sample -s50 $illumina_reads_R2 1280400693 > ${out}/illumina_reads_R2_0.9.fasta
