#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=400G   # memory per Nodes   #38
#SBATCH -J "mapping"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mappingmelo-%j.err
#SBATCH -o slurm-mappingmelo-%j.out
#SBATCH -p all

module purge
module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/database/hub/SINGULARITY_GALAXY/bwa-mem2:2.2.1--hd03093a_2'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /dataspecies/hub:/dataspecies/hub'

cd "/kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/mobilome"
REF="reads__all_Minc.fastq.gz"

fq1="Minc_mobilome_R1.fastq.gz"
fq2="Minc_mobilome_R2.fastq.gz"

OUT1="Minc_mobilome_ONTreads.sam"

#$SING2 $SING_IMG bwa-mem2 index $REF
#echo 'index read ok'

#$SING2 $SING_IMG bwa-mem2 mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $OUT1
#echo 'mapping read ok'

SING_IMG="/database/hub/SINGULARITY_GALAXY/samtools:1.9--h91753b0_8"
bam="Minc_mobilome_ONTreads.bam"
$SING2 $SING_IMG samtools view --threads $SLURM_JOB_CPUS_PER_NODE -S -b $OUT1 > $bam
echo 'mapping view ok'
$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE $bam -o $bam.sorted
echo 'mapping sorted ok'
$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
echo 'mapping index ok'
$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.depth
echo 'mapping depth ok'
$SING2 $SING_IMG samtools coverage $bam.sorted >  $bam.sorted.coverage
echo 'mapping coverage ok'
$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.stat
echo 'mapping stat ok'

