#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
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

out_rep="/kwak/hub/25_cbelliardo/MISTIC/Salade_I/circ_dna/"


#$SING2 $SING_IMG minimap2 -x map-hifi -d $hifi.mmi $hifi ##map-hifi ou splice:hq
#echo "index ok"

$SING2 $SING_IMG minimap2 -t 60 -ax map-hifi --secondary=yes $hifi $hifi > ${out_rep}hifiR-vs-hifiR__map_hifi.sam
echo 'map1 ok'

#$SING2 $SING_IMG minimap2 -t 60 -ax splice:hq --secondary=yes $hifi $hifi > ${out_rep}hifiR-vs-hifiR_splice_hq.sam
#echo 'map2 ok'

#$SING2 $SING_IMG bwa-mem2 mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $OUT1
#echo 'mapping read ok'

#sam=$OUT1
#bam="cleaned_Salade_S1_L001__vs__hifireads.bam"
#$SING2 $SING_IMG samtools view --threads $SLURM_JOB_CPUS_PER_NODE -S -b $sam > $bam
#echo 'mapping view ok'
#$SING2 $SING_IMG samtools sort --threads $SLURM_JOB_CPUS_PER_NODE $bam -o $bam.sorted
#echo 'mapping sorted ok'
#$SING2 $SING_IMG samtools index --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
#echo 'mapping index ok'
#$SING2 $SING_IMG samtools depth --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.depth
#echo 'mapping depth ok'
$SING2 $SING_IMG samtools coverage $bam.sorted >  $bam.sorted.coverage
#echo 'mapping coverage ok'
#$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE $bam.sorted >  $bam.sorted.stat
#echo 'mapping stat ok'
