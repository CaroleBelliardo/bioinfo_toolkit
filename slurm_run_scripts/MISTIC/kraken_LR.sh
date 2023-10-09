#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=120     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
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

db='/database/hub/NT/NT_kraken' 
out=$2
FILENAME=$3


$SING2 $SING_IMG kraken2 --use-names --threads $SLURM_JOB_CPUS_PER_NODE --db $db --confidence 0.03 --output $out --report $out.report $FILENAME

## run kraken
#$ sbatch kraken_LR.sh <wd_path> <outputname> <filename> 
#$ sbatch kraken_LR.sh '/kwak/hub/25_cbelliardo/MISTIC/Salade_I/5_kraken/fasta' 'hifi_reads.krak' 'salade_I_fev__hifi_reads.fasta'
#$ sbatch kraken_LR.sh '/kwak/hub/25_cbelliardo/MISTIC/Salade_I/5_kraken/fasta' 'hifi_assembly_asm3.krak' 'contig_salade_I_fev_hifi__asm3.fasta'
#$ sbatch kraken_LR.sh '/kwak/hub/25_cbelliardo/MISTIC/Salade_I/5_kraken/fasta' 'hifi_assembly_metafly.krak' 'contig_salade_I_fev_hifi__metafly.fasta'

