#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "kraken"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-kraken-%j.err
#SBATCH -o slurm-kraken-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/database/hub/SINGULARITY_GALAXY/MetagAssembler.sif'
SING2='singularity exec --bind /kwak/hub'

cd $1
#FILES=($(ls -1 *.fasta))
#FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

db='/database/hub/NT/NT_kraken' 
FILENAME1=$2
FILENAME2=$3
out=$4
#out1=$5
#out2=$6    

$SING2 $SING_IMG kraken2 --paired --use-names --gzip-compressed --threads $SLURM_JOB_CPUS_PER_NODE --db $db --confidence 0.03 --output $out --report $out.report $FILENAME1 $FILENAME2  #--classified-out $out1 --unclassified-out $out2

## run kraken
#$ sbatch kraken.sh <wd_path> <outputname> <filename1> <filename2> # <clasifiedOUT> <UNclassifiedOUT> 
#$ sbatch kraken.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/01_clean_qc/01_1_cleaned_reads cleaned_run1.krak cleaned_run1_R1.fastq.gz cleaned_run1_R2.fastq.gz # cleaned_run1_#_Kclassified cleaned_run1_#_Kunclassified
#$ sbatch kraken.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/01_clean_qc/01_2_cleaned_reads cleaned_run2.krak cleaned_run2_R2.fastq.gz cleaned_run2_R2.fastq.gz  #cleaned_run2_#_Kclassified cleaned_run2_#_Kunclassified