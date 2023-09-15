#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=480G   # memory per Nodes   #38
#SBATCH -J "samtool"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-bam-%j.err
#SBATCH -o slurm-bam-%j.out
#SBATCH -p treed

module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

p=$1
cd $1

FILES=($(ls -1 *.bam))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

#$SING2 $SING_IMG /lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/samtools/samtools index $FILENAME
$SING2 $SING_IMG /lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/samtools/samtools view -@60 $FILENAME | cut -f 1 > /lerins/hub/projects/25_IPN_Metag/compare-pc/mappedReads/${FILENAME}_${2}_mappedread.txt


