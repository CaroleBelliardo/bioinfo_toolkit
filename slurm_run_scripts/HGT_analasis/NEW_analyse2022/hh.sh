#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
#SBATCH -J "a23"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a22-%j.err
#SBATCH -o slurm-a22-%j.out
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

$SING2 $SING_IMG echo "tmp"
