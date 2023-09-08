#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=48     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=540G   # memory per Nodes
#SBATCH -J "diamond"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/diamond_0.9.29.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"

#p=/work/cbelliardo/4-seuil_cut-Metag/Faa_1000l-3g
#r=${p}/${1}_${SLURM_ARRAY_TASK_ID}
cd $1
mkdir daa_All

for f in *split*
 do
   $SING2 $SING_IMG diamond blastp  --more-sensitive -b6 -c1  -e 0.000001 -f 100 --top 10 -d /bighub/hub/DB/diamond_ncbi_nr_2020_01 -q $f -o daa_All/${f}.daa
  done





