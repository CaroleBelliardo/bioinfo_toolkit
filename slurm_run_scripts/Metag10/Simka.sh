#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes   #38
#SBATCH -J "summ-mgr"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-gff-%j.err
#SBATCH -o slurm-gff-%j.out
#SBATCH -p all
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub' 


FILES=($(ls -1 *))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

