#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=2     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=16G   # memory per Nodes   #38
#SBATCH -J "dsk"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dsk-%j.err
#SBATCH -o slurm-dsk-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/dsk_2.3.3'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd /kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve

input=$1
output=$2
outputxt=$3

solid_kmer=echo input | awk -F '.' '{print $2}'
echo $input ':' $solid_kmer

$SING2 $SING_IMG dsk -nb-cores $SLURM_JOB_CPUS_PER_NODE -file $input -out $output -abundance-min $solid_kmer > $outputxt

#$SING2 $SING_IMG dsk2ascii -file $output -out $outputxt
