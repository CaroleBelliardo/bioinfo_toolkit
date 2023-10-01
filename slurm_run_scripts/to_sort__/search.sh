#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=72G   # memory per Nodes
#SBATCH -J "search"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"


#$SING2 $SING_IMG mmseqs createdb metag_G-rosea.fa queryDB
#$SING2 $SING_IMG mmseqs search queryDB /bighub/hub/DB/mmseq_swissprot/swissprot resultDB tmp
#$SING2 $SING_IMG mmseqs convertalis queryDB /bighub/hub/DB/mmseq_swissprot/swissprot resultDB resultDB.m8
## ou
#$SING2 $SING_IMG mmseqs easy-linsearch /work/cbelliardo/6-ensembl_clust/metag_G-rosea.fa /bighub/hub/DB/mmseq_swissprot/swissprot out tmp --search-type 2 -v 3 --threads 8
