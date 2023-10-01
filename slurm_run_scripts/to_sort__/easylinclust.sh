#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=72G   # memory per Nodes
#SBATCH -J "easylinclust"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

$SING2 $SING_IMG mmseqs easy-linclust /work/cbelliardo/4-seuil_cut-Metag/Faa_1000l-3g/DataOri/AllrenameHeader_data23_suppl.fa query_clust tmp --min-seq-id 0.9  --threads 1 --cov-mode 1 -c 0.9 --cluster-mode 2


