#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=450G   # memory per Nodes   #38
#SBATCH -J "bedcov"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-bedcov-%j.err
#SBATCH -o slurm-bedcov-%j.out
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'
SING_IMG="/database/hub/SINGULARITY_GALAXY/samtools:1.9--h91753b0_8"
#func def
check_command() {
  if [ $? -eq 0 ]; then
    echo "Command successful"
  else
    echo "Error in command"
    exit 1
  fi
}

bed=$1
bam=$2
out=$3
$SING2 $SING_IMG samtools bedcov $bed $bam > $out
check_command

# run with: sbatch covbed.sh <bed> <bam> <out>
