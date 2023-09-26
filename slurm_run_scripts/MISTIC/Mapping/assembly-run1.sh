#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=200     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=1000G   # memory per Nodes   #38
#SBATCH -J "st_run1"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-stLR-run1-%j.err
#SBATCH -o slurm-stLR-run1-%j.out
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

## ---
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly"
bam=cleaned_run1__vs__hifi_assembly.bam

SING_IMG='/database/hub/SINGULARITY_GALAXY/sambamba_1.0--h98b6b92_0'

$SING2 $SING_IMG sambamba sort -m 1000G -t $SLURM_JOB_CPUS_PER_NODE -o $bam.sorted --tmpdir ./tmp_sambamba_assembly_run1 $bam
check_command

$SING2 $SING_IMG sambamba index --nthreads $SLURM_JOB_CPUS_PER_NODE $bam.sorted
check_command

$SING2 $SING_IMG sambamba flagstat -p -t $SLURM_JOB_CPUS_PER_NODE $bam.sorted > $bam.sorted_flasgstat
check_command

$SING2 $SING_IMG sambamba markdup -r -p -t $SLURM_JOB_CPUS_PER_NODE --tmpdir tmp-run1 $bam.sorted $bam.sorted.rmdup
check_command

$SING2 $SING_IMG sambamba flagstat -p -t $SLURM_JOB_CPUS_PER_NODE $bam.sorted.rmdup > $bam.sorted.rmdup_flasgstat

##run
# $ sbatch mappingSRLR2.sh "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly" "hifi_reads" "cleaned_run2_R1.fastq.gz" "cleaned_run2_R2.fastq.gz" "cleaned_run2__vs__hifiLR"
