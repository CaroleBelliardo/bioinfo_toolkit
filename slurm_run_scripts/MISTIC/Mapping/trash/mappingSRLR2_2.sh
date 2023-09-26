#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=480G   # memory per Nodes   #38
#SBATCH -J "st"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-stLR-%j.err
#SBATCH -o slurm-stLR-%j.out
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

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/bwa-mem2:2.2.1--hd03093a_2'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd $1 #"/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly"
REF=$2

fq1=$3
fq2=$4

OUT=$5

# Verifier la présence de fichiers .amb dans le répertoire courant
if ls -1 *.amb >/dev/null 2>&1; then
  echo "index files exists"
else
   #Si aucun fichier .amb n'existe, exécuter la commande
  echo "no index files, run bam index"
  $SING2 $SING_IMG bwa-mem2 index $REF
fi

#$SING2 $SING_IMG bwa-mem2 mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $OUT.sam
#echo 'mapping read ok'

SING_IMG="/database/hub/SINGULARITY_GALAXY/samtools:1.9--h91753b0_8"

sam=$OUT.sam
bam=$OUT.bam

#$SING2 $SING_IMG samtools view -m 460G --threads $SLURM_JOB_CPUS_PER_NODE -o $bam -S -b $sam
#check_command

$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE -o $bam.sorted $bam
check_command

$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
check_command

$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE -o $bam.sorted.depth $bam.sorted
check_command

$SING2 $SING_IMG samtools coverage -o $bam.sorted.coverage $bam.sorted
check_command

$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE -o $bam.sorted.stat $bam.sorted
check_command

##run
# $ sbatch mappingSRLR2.sh "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly" "hifi_reads" "cleaned_run2_R1.fastq.gz" "cleaned_run2_R2.fastq.gz" "cleaned_run2__vs__hifiLR"
