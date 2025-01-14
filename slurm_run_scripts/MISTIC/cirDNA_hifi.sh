#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G   # memory per Nodes   #38
#SBATCH -J "mapping"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mappingLR-%j.err
#SBATCH -o slurm-mappingLR-%j.out
#SBATCH -p all

module purge
module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/database/hub/SINGULARITY_GALAXY/minimap2:2.24--h5bf99c6_0'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/"
ref="assemblage_LR/contig_salade_I_fev_hifi__asm3.fasta"

hifi="hifi_reads/salade_I_fev__hifi_reads.fastq"

fq1="2_QC_fastq$/cleaned_Salade_S1_L001__R1.fastq"
fq2="2_QC_fastq$/cleaned_Salade_S1_L001__R2.fastq"

out_rep="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/circ_dna/hifiRead_vs_assemblage_secondary"


#$SING2 $SING_IMG minimap2 -x map-hifi -d $ref.mmi $ref ##map-hifi ou splice:hq
#echo "index ok"

$SING2 $SING_IMG minimap2 -t 60 -ax map-hifi --secondary=yes $ref $hifi > ${out_rep}_map_hifi.sam
echo 'map1 ok'


SING_IMG='/kwak/hub/25_cbelliardo/MISTIC/tools/metagwgs/env/metagwgs.sif'

$SING2 $SING_IMG samtools view --threads $SLURM_JOB_CPUS_PER_NODE -S -b ${out_rep}_map_hifi.sam > ${out_rep}_map_hifi.bam
echo 'mapping view ok'

$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE $bam -o ${out_rep}_map_hifi_sorted.bam ${out_rep}_map_hifi.bam
echo 'mapping sorted ok'

$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE ${out_rep}_map_hifi_sorted.bam
echo 'mapping index ok'

$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE  >  ${out_rep}_map_hifi_sorted.bam.depth
echo 'mapping depth ok'

$SING2 $SING_IMG samtools coverage ${out_rep}_map_hifi_sorted.bam >  ${out_rep}_map_hifi_sorted.bam.coverage
#echo 'mapping coverage ok'

$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE ${out_rep}_map_hifi_sorted.bam >  ${out_rep}_map_hifi_sorted.bam.stat
echo 'mapping stat ok'
