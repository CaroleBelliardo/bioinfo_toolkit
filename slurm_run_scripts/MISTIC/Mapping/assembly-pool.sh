#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=10     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=80G   # memory per Nodes   #38
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

#ulimit -n 20000

## -- makedb
#SING_IMG='/database/hub/SINGULARITY_GALAXY/bwa-mem2:2.2.1--hd03093a_2'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw'

cd "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly"
bam='cleaned_pool__vs__hifiassembly.bam.sorted'


#SING_IMG="/database/hub/SINGULARITY_GALAXY/metagwgs.sif"
#SING_IMG='/database/hub/SINGULARITY_GALAXY/sambamba_1.0--h98b6b92_0'


#$SING2 $SING_IMG sambamba markdup -r -p -t $SLURM_JOB_CPUS_PER_NODE --tmpdir tmp_dir_pool $bam $bam.rmdup
#check_command

#$SING2 $SING_IMG sambamba flagstat -p -t $SLURM_JOB_CPUS_PER_NODE $bam.rmdup > $bam.rmdup_flasgstat
#check_command

SING_IMG="/database/hub/SINGULARITY_GALAXY/metagwgs.sif"
$SING2 $SING_IMG samtools coverage -o $bam.coverage $bam
check_command

$SING2 $SING_IMG samtools stats --threads $SLURM_JOB_CPUS_PER_NODE -o $bam.stat $bam
check_command

##run
# $ sbatch mappingSRLR2.sh
