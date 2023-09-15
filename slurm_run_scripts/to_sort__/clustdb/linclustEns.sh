#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=124G   # memory per Nodes
#SBATCH -J "enBlinclust"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/mmseqs2.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"


cd /bighub/hub/DB/
tar zxvf ensembl_save.tar.gz
for i in ensembl_save
do cat $i >> ensembl_20200215.fa
done 
$SING2 $SING_IMG mmseqs easy-linclust /bighub/hub/DB/ensembl_20200215.fa /hub/DB/clust_db/ensembl_clust0.9 tmpens --min-seq-id 0.9  --threads 32 --cov-mode 1 -c 0.9 --cluster-mode 2
rm tmpens
