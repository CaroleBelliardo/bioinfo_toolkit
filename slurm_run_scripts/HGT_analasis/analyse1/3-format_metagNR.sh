#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=6     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=350G   # memory per Nodes   #38
#SBATCH -J "formatDB1"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-formatDB-%j.err
#SBATCH -o slurm-formatDB-%j.out
#SBATCH -p infinity

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

$SING2 $SING_IMG python /work/cbelliardo/scripts/python/format_metaNR-DB.py
