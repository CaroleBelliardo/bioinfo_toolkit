#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=50     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=400G   # memory per Nodes   #38
#SBATCH -J "mapping"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mappingLR-%j.err
#SBATCH -o slurm-mappingLR-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/kwak/hub/25_cbelliardo/25_MISTIC/tools/metagwgs/env/metagwgs.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw --bind /lerins/hub:/lerins/hub'

cd "/kwak/hub/25_cbelliardo/25_MISTIC/Salade_I/mapping_SR_LR_assembly"
REF="hifi_assembly"

fq1="cleaned_Salade_S1_L001__R1.fastq"
fq2="cleaned_Salade_S1_L001__R2.fastq"
OUT1=cleaned_Salade_S1_L001__vs__hifi_assembly.sam

#$SING2 $SING_IMG bwa index -a bwtsw $REF 
#echo 'index read ok'

#$SING2 $SING_IMG bwa mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $OUT1
#echo 'mapping read ok'


sam="cleaned_Salade_S1_L001__vs__hifi_assembly.sam"
bam="cleaned_Salade_S1_L001__vs__hifi_assembly.bam"
#$SING2 $SING_IMG samtools view --threads $SLURM_JOB_CPUS_PER_NODE -S -b $sam > $bam
#echo 'mapping view ok'
#$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE $bam -o $bam.sorted
#echo 'mapping sorted ok'
#$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
#echo 'mapping index ok'
#$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.depth
#echo 'mapping depth ok'
$SING2 $SING_IMG samtools coverage $bam.sorted >  $bam.sorted.coverage
echo 'mapping coverage ok'
#$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.stat
#echo 'mapping stat ok'
