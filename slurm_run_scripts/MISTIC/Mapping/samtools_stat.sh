#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=10     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=80G   # memory per Nodes   #38
#SBATCH -J "st_run2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-stLR_run2-%j.err
#SBATCH -o slurm-stLR_run2-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/database/hub/SINGULARITY_GALAXY/samtools:1.9--h91753b0_8'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd $1
input=$2
$SING2 $SING_IMG samtools stats -@ $SLURM_JOB_CPUS_PER_NODE $input > ${input}_samtools.stats
$SING2 $SING_IMG samtools depth -@ $SLURM_JOB_CPUS_PER_NODE $input > ${input}_samtools.depth


## run
# $ sbatch samtools_stat.sh <path> <bam> 
# $ sbatch samtools_stat.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly cleaned_pool__vs__hifiassembly.bam.sorted