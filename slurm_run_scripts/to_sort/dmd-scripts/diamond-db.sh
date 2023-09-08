#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "diamond"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/diamond_0.9.29.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"


$SING2 $SING_IMG diamond makedb --in /bighub/hub/DB/diamond_ncbi_nr_2020_01/nr.gz -d /bighub/hub/DB/diamond_ncbi_nr_2020_01 --taxonmap /bighub/hub/DB/diamond_ncbi_nr_2020_01/prot.accession2taxid  --taxonnodes /bighub/hub/DB/diamond_ncbi_nr_2020_01/taxdmp/nodes.dmp

 
