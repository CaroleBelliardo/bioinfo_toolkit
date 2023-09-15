#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=250G   # memory per Nodes   #38
#SBATCH -J "curve_hifi"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-curve_hifi-%j.err
#SBATCH -o slurm-curve_hifi-%j.out
#SBATCH -p all

module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/kwak/hub/25_cbelliardo/25_MISTIC/tools/seqtk_1.4.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /kwak/hub:/kwak/hub:rw --bind /lerins/hub:/lerins/hub'

cd "/kwak/hub/25_cbelliardo/25_MISTIC/Salade_I/curve/HIFI"

hifi_reads="hifi_reads"

out="subsampling"

$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 291301 > ${out}/hifi_reads_0.1.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 582603 > ${out}/hifi_reads_0.2.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 873904 > ${out}/hifi_reads_0.3.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 1165206 > ${out}/hifi_reads_0.4.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 1456508 > ${out}/hifi_reads_0.5.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 1747809 > ${out}/hifi_reads_0.6.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 2039111 > ${out}/hifi_reads_0.7.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 2330412 > ${out}/hifi_reads_0.8.fasta
$SING2 $SING_IMG seqtk sample -s100 $hifi_reads 2621714 > ${out}/hifi_reads_0.9.fasta
