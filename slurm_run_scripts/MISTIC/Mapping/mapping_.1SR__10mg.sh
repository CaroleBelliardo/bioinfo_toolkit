#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G   # memory per Nodes   #38
#SBATCH -J "mapCat"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mapCat-%j.err
#SBATCH -o slurm-mapCat-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
#func def
check_command() {
  if [ $? -eq 0 ]; then
    echo "Command successful"
  else
    echo "Error in command"
    exit 1
  fi
}

ulimit -n 20000

SING_IMG='/database/hub/SINGULARITY_GALAXY/bwa-mem2:2.2.1--hd03093a_2'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/10_typicite"
REF='cat_10metag.fasta'

fq1='illumina_reads_R1_0.1.fasta'
fq2='illumina_reads_R1_0.2.fasta'

out='cleaned_pool_0.1__vs__cat_10metag'

$SING2 $SING_IMG bwa-mem2 index $REF
echo 'index ok'
$SING2 $SING_IMG bwa-mem2 mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $out.sam
echo 'mapping read ok'