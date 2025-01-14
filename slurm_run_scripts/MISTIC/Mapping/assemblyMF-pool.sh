#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=240G   # memory per Nodes   #38
#SBATCH -J "mappingMf"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-Mf-%j.err
#SBATCH -o slurm-Mf-%j.out
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
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw"

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly"
# REF='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_assemblage_LR/metafly/assembly.fasta'
# fq1='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R1.fastq.gz'
# fq2='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/cleaned_pool_R2.fastq.gz'

out='cleaned_pool__vs__hifiassemblyMF'

#$SING2 $SING_IMG bwa-mem2 index $REF
# echo 'index ok'
# $SING2 $SING_IMG bwa-mem2 mem -t $SLURM_JOB_CPUS_PER_NODE $REF $fq1 $fq2 > $out.sam
# echo 'mapping read ok'

sam=$out.sam
bam=$out.bam

SING_IMG='/database/hub/SINGULARITY_GALAXY/sambamba_1.0--h98b6b92_0'
$SING2 $SING_IMG sambamba view --nthreads $SLURM_JOB_CPUS_PER_NODE -f 'bam' -o $bam -S $sam
check_command

# TODO : sort

# $SING2 $SING_IMG sambamba sort -m 26G -t $SLURM_JOB_CPUS_PER_NODE -o $bam.sorted --tmpdir ./tmp_sambamba_$5 $bam
# check_command

# $SING2 $SING_IMG sambamba index --nthreads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
# check_command

# $SING2 $SING_IMG sambamba flagstat -p -t $SLURM_JOB_CPUS_PER_NODE $bam.sorted > $bam.sorted_flasgstat

# bam=$bam.sorted
# $SING2 $SING_IMG sambamba markdup -r -p -t $SLURM_JOB_CPUS_PER_NODE --tmpdir tmp_dir_pool $bam $bam.rmdup
# check_command

# $SING2 $SING_IMG sambamba flagstat -p -t $SLURM_JOB_CPUS_PER_NODE $bam.rmdup > $bam.rmdup_flasgstat
# check_command

#SING_IMG="/database/hub/SINGULARITY_GALAXY/metagwgs.sif"
#$SING2 $SING_IMG samtools coverage -o $bam.rmdup.coverage $bam.rmdup
#check_command

#$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE -o $bam.stat $bam
#check_command

##run
# $ sbatch mappingMF-pool.sh
