#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=126G   # memory per Nodes   #38
#SBATCH -J "dmd NOT"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

db='/lerins/hub/DB/NR/NR_diamond/NR_2020_01_diamond.dmnd'

#QUERY='/lerins/hub/projects/25_IPN_Metag/10MetagPool/hgt/protid.aa'
#OUT='/lerins/hub/projects/25_IPN_Metag/10MetagPool/hgt/protid.dmd'

#Run a search in blastp mode
cd /lerins/hub/projects/25_Metag_PublicData/PAPER1/Review_Sdata/R2_1_models/RR2/fasta/VALIDATED_mix
FILES=($(ls -1 *.aa))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.aa | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

QUERY=$FILENAME
OUT=${PREF}.dmd
$SING2 $SING_IMG diamond blastp --more-sensitive -k500  -b 8 -c 1 -p 70 --outfmt 102 -d $db -q $QUERY -o $OUT 

