#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "dmdT"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/diamond_0.9.29.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"


cd $1
mkdir Taxonomic_classif


for f in *.daa
 do
   $SING2 $SING_IMG diamond view -f 102 --daa $f --out Taxonomic_classif/${f}.taxo
  done
  
