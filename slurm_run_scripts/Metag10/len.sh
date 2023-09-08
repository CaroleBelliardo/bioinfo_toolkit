#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "wcl"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mg-%j.err
#SBATCH -o slurm-mg-%j.out
#SBATCH -p treed

module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_Metag/10Metag/fasta'
cd $wd

FILES=($(ls -1 *.fasta))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.fasta | cut -f1 -d'.'))
PREF=${PREFS[$SLURM_ARRAY_TASK_ID]}

fileOutput=/lerins/hub/projects/25_IPN_Metag/10Metag/len/${PREF}.nbs

grep -Fc '>' $FILENAME  > $fileOutput

