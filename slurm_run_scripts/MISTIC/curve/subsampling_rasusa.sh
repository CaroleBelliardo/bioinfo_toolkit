#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
#SBATCH -J "subsamp"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-ssp-%j.err
#SBATCH -o slurm-ssp-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/rasusa:0.7.1--hec16e2b_1'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw '

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve/illumina/pool/"

illumina_reads_R1="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R1.fastq.gz"
illumina_reads_R2="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R2.fastq.gz"

out='subsampling2'
$SING2 $SING_IMG rasusa -s 10 -n 142266744 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.1.fasta -o ${out}/illumina_reads_R2_0.1.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 284533487 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.2.fasta -o ${out}/illumina_reads_R2_0.2.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 426800231 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.3.fasta -o ${out}/illumina_reads_R2_0.3.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 569066975 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.4.fasta -o ${out}/illumina_reads_R2_0.4.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 711333719 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.5.fasta -o ${out}/illumina_reads_R2_0.5.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 853600462 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.6.fasta -o ${out}/illumina_reads_R2_0.6.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 995867206 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.7.fasta -o ${out}/illumina_reads_R2_0.7.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 1138133950 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.8.fasta -o ${out}/illumina_reads_R2_0.8.fasta -O g
$SING2 $SING_IMG rasusa -s 10 -n 1280400693 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.9.fasta -o ${out}/illumina_reads_R2_0.9.fasta -O g

out='subsampling3'
$SING2 $SING_IMG rasusa -s 50 -n 142266744 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.1.fasta -o ${out}/illumina_reads_R2_0.1.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 284533487 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.2.fasta -o ${out}/illumina_reads_R2_0.2.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 426800231 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.3.fasta -o ${out}/illumina_reads_R2_0.3.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 569066975 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.4.fasta -o ${out}/illumina_reads_R2_0.4.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 711333719 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.5.fasta -o ${out}/illumina_reads_R2_0.5.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 853600462 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.6.fasta -o ${out}/illumina_reads_R2_0.6.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 995867206 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.7.fasta -o ${out}/illumina_reads_R2_0.7.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 1138133950 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.8.fasta -o ${out}/illumina_reads_R2_0.8.fasta -O g
$SING2 $SING_IMG rasusa -s 50 -n 1280400693 -i $illumina_reads_R1 -i $illumina_reads_R2 -o ${out}/illumina_reads_R1_0.9.fasta -o ${out}/illumina_reads_R2_0.9.fasta -O g

