#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=120     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
#SBATCH -J "kraken"-$1   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-kraken-$1-%j.err
#SBATCH -o slurm-kraken-$1-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/database/hub/SINGULARITY_GALAXY/MetagAssembler.sif'
SING2='singularity exec --bind /kwak/hub'

cd $1
FILES=($(ls -1 *.fast*))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

db='/database/hub/NT/NT_kraken' 

out=$FILENAME.krak

$SING2 $SING_IMG kraken2 --use-names --threads $SLURM_JOB_CPUS_PER_NODE --db $db --confidence 0.03 --output $out --report $out.report $FILENAME 

## run kraken
#$ sbatch --array=0-<nb of fasta or fastq file> kraken.sh <wd_path> 
#$ sbatch --array=0-9 kraken_contigs.sh /kwak/hub/25_cbelliardo/MetaNema_LRmg/10Metag/assembly/hifiasm3
