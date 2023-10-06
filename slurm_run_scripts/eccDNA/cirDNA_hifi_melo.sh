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

# Set the path to the Singularity image for minimap2
SING_IMG='/database/hub/SINGULARITY_GALAXY/minimap2:2.24--h5bf99c6_0'

# Set the command to execute Singularity with the necessary bind mounts
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

# Set the path to the reference genome
ref="/kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Minc_v4_shac_genome.fasta"

# Set the path to the Nanopore reads
ont="all_Minc.fastq.gz"

# Set the output directory
out_rep="./"

# Index the reference genome with minimap2
#$SING2 $SING_IMG minimap2 -x map-ont -d $ref.mmi $ref ##map-hifi ou splice:hq
#echo "index ok"

# Map the Nanopore reads to the reference genome with minimap2
#$SING2 $SING_IMG minimap2 -t 60 -ax map-ont --secondary=yes $ref $ont > ${out_rep}_map.sam
#echo 'map1 ok'

# Set the path to the Singularity image for samtools
SING_IMG='/kwak/hub/25_cbelliardo/MISTIC/tools/metagwgs/env/metagwgs.sif'

# Convert the SAM file to BAM format
#$SING2 $SING_IMG samtools view --threads $SLURM_JOB_CPUS_PER_NODE -S -b ${out_rep}_map.sam > ${out_rep}_map.bam
#echo 'mapping view ok'

# Sort the BAM file
#$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE $bam -o ${out_rep}_map_sorted.bam ${out_rep}_map.bam
#echo 'mapping sorted ok'

# Index the sorted BAM file
$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE ${out_rep}_map_sorted.bam
echo 'mapping index ok'

# Calculate the depth of coverage for each position in the genome
$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE ${out_rep}_map_sorted.bam  >  ${out_rep}_map_sorted.bam.depth
echo 'mapping depth ok'

# Calculate the coverage statistics for the BAM file
$SING2 $SING_IMG samtools coverage ${out_rep}_map_sorted.bam >  ${out_rep}_map_sorted.bam.coverage
#echo 'mapping coverage ok'

# Calculate the alignment statistics for the BAM file
$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE ${out_rep}_map_sorted.bam >  ${out_rep}_map_sorted.bam.stat
echo 'mapping stat ok'
