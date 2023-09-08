#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=164G   # memory per Nodes
#SBATCH -J "3easylinclust"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/lerins/hub/projects/25_tools/singularity/mmseq2"
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd $1
fasta=$2
out=$2.clust3 

$SING2 $SING_IMG mmseqs easy-linclust $fasta $out tmp --min-seq-id 0.99  --threads 20 --cov-mode 3 -c 0.001 --cluster-mode 1
echo $out

