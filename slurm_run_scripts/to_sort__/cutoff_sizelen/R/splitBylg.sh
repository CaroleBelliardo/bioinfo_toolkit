#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=190G   # memory per Nodes
#SBATCH -J "catCross"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG=/home/singularity/images/Trinity_2.4.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"


#for i in /work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff/*;
  #do 
   # cat $i >> /work/cbelliardo/4-seuil_cut-Metag/CAT_all.txt
  #done 
#awk 'BEGIN { FS = OFS = "\t" } { for(i=1; i<=NF; i++) if($i ~ /^ *$/) $i = 0 }; 1' /work/cbelliardo/4-seuil_cut-Metag/CAT_all.txt > /work/cbelliardo/4-seuil_cut-Metag/CAT_all-zero.txt

python3 /work/cbelliardo/4-seuil_cut-Metag/splitBylg.py /work/cbelliardo/4-seuil_cut-Metag/CAT_all-zero.txt
