#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=496G   # memory per Nodes   #38
#SBATCH -J "pv1"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-pb-%j.err
#SBATCH -o slurm-pb-%j.out
#SBATCH -p infinity

module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/star.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo  --bind /lerins/hub:/lerins/hub'

cd /lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/8_parcoursTree/Mgrami
Mgrami_nr=/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/0_genome/MgramiNR/GCA_014773135.1/ncbi_dataset/data/GCA_014773135.1/GCA_014773135.1_ASM1477313v1_genomic.fna

$SING2 $SING_IMG STAR --runThreadN  60 --genomeFastaFiles  $in --runMode genomeGenerate --genomeDir Mgrami_nr --genomeFastaFiles $Mgrami_nr --outFileNamePrefix star_index
#$SING2 $SING_IMG STAR --runThreadN  $SLURM_CPUS_PER_TASK 
