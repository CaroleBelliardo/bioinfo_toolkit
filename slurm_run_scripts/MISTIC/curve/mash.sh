#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=164G   # memory per Nodes   #38
#SBATCH -J "mash"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mash-%j.err
#SBATCH -o slurm-mash-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='tools/mash*'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw'

cd /kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/mash/data/

fastq_hifi='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/HIFI/subsampling1/hifi_reads_1.fasta'
fastq_illumina_1_1='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R1_0.1.fastq'
fastq_illumina_1_2='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R2_0.1.fastq'
fastq_illumina1_1='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R1_1.fastq'
fastq_illumina1_2='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R2_1.fastq'
fast_illumina_5_1='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R1_0.5.fastq'
fast_illumina_5_2='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/illumina_reads_R2_0.5.fastq'

ref='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/tmp/illumina_reads_1.fastq'
fastq_illuminaRun_5='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/tmp/illumina_reads_.5.fastq'
fastq_illuminaRun_1='/kwak/hub/25_cbelliardo/MISTIC/Salade_I/curve/illumina/fastq_sampling/subsampling1/tmp/illumina_reads_.1.fastq'


cat ${fastq_illumina_1_1} ${fastq_illumina_1_2} >${fastq_illuminaRun_1}
cat ${fastq_illumina1_1} ${fastq_illumina1_2} > ${ref}
cat ${fast_illumina_5_1} ${fast_illumina_5_2} >${fastq_illuminaRun_5}

$SING2 $SING_IMG mash sketch -m 2 -p 20 ${fastq_illuminaRun_1} 
$SING2 $SING_IMG mash sketch -m 2 -p 20 $fastq_hifi
$SING2 $SING_IMG mash sketch -m 2 -p 20 ${fast_illumina_5}

$SING2 $SING_IMG  mash dist $ref ${fastq_illuminaRun_1}.msh ${fast_illumina_5}.msh $fastq_hifi.msh > distances.tab

sort -gk3 distances.tab | head
