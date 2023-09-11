#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=124     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=124G   # memory per Nodes
#SBATCH -J "kraken"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e /work/cbelliardo/zslurm-jobs/slurm-%j.err
#SBATCH -o /work/cbelliardo/zslurm-jobs/slurm-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools2.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"
#DBNAME=cmaK
#${SLURM_CPUS_PER_TASK}
#${SLURM_ARRAY_TASK_ID}
FILES=($(ls -1 *aa))
MODELS=($(ls -1 *.aa | cut -d"." -f1))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
MODEL=${MODELS[$SLURM_ARRAY_TASK_ID]}


python p.py
