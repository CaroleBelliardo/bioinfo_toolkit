#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=6     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "dsk"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dsk-%j.err
#SBATCH -o slurm-dsk-%j.out
#SBATCH -p treed

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/dsk_2.3.3'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd /kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve

input=$1
ksize=$4
output=${2}_2kmer_$ksize
outputxt=${3}_2kmer_$ksize


bn=$(basename $input)
bnn=$(echo $bn | sed 's/\.fasta//') 
IFS='_' read -ra parts <<< "$bnn"
solid_kmer=${parts[-1]}
echo $input ':' $solid_kmer


# multiply solid_kmer by 20
solid_kmer=$(echo "$solid_kmer" | awk '{printf "%d", $1 * 10}')
echo $input "* 10" ':' $solid_kmer

$SING2 $SING_IMG dsk -nb-cores $SLURM_JOB_CPUS_PER_NODE -file $input -out $output  -kmer-size $ksize > $outputxt # -abundance-min $solid_kmer
#$SING2 $SING_IMG dsk2ascii -file $output -out $outputxt
