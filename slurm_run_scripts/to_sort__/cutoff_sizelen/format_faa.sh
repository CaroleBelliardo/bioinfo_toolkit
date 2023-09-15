#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "h"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/diamond_0.9.29.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"

#p=/work/cbelliardo/4-seuil_cut-Metag/Faa_1000l-3g
#r=${p}/${1}_${SLURM_ARRAY_TASK_ID}
cd $1
mkdir renameHeader

for f in *fa
 do
   awk  '/^>/ {gsub(/.a.fa(sta)?$/,"",FILENAME);printf($0 "_" FILENAME "\n");next;} {print}' $f > renameHeader/$f
   
  #$SING2 $SING_IMG diamond blastp  --more-sensitive -f 100 -k 150 -d /bighub/hub/DB/diamond_ncbi_nr_2020_01 -q $f -o ${f}.daa
  done





