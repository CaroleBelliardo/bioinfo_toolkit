#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "format"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-format-%j.err
#SBATCH -o slurm-format-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

path='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/7-AHS/1-dmd'
cd $path

FILES=($(ls -1 *.txt))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG python /work/cbelliardo/scripts/python/format_dmdAI.py $FILENAME
