#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=32     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=256G   # memory per Nodes
#SBATCH -J "enslinclust"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/mmseqs2.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"


$SING2 $SING_IMG mmseqs easy-linclust /bighub/hub/DB/NT_fasta/nt /bighub/hub/DB/clust_db/nt_clust0.9 tmpnt --min-seq-id 0.9  --threads 32 --cov-mode 1 -c 0.9 --cluster-mode 2
