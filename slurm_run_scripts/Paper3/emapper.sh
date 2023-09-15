#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=464G   # memory per Nodes   #38
#SBATCH -J "emapper"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/lerins/hub/projects/25_tools/singularity/eggnog-mapper:2.1.9--pyhdfd78af_0'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


#Run a search in blastp mode
cd /lerins/hub/projects/25_IPN_Metag/10Metag/Proteins
FILES=($(ls -1 *.aa))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.aa | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

db="/lerins/hub/DB/Metagenomics/eggnog/eggnog-mapper"
QUERY="h.aa"
OUT=${h.aa}.em3

$SING2 $SING_IMG  emapper.py --data_dir $db -i /lerins/hub/projects/25_MetaNema/10Metag/Proteins/h.aa -o /lerins/hub/projects/25_MetaNema/10Metag/Proteins/h.aa.emapper #$QUERY -o $OUT 

