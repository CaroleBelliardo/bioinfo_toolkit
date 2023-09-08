#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=16G   # memory per Nodes
#SBATCH -J "gzcat"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd $1

for i in *.fa
   do 
#echo $i >> /work/cbelliardo/6-ensembl_clust/ensemble_nb_tot_seq.txt
      grep -c '>' $i >> nb_tot_seq.txt
done
