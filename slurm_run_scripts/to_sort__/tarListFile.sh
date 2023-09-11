#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4    # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=40G   # memory per Nodes
#SBATCH -J "tar"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/home/singularity/images/blast_2.9.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd /bighub/hub/DB/refseq_genomic_blast/blast_refseq_genomic_v4/targz/
nb=${SLURM_ARRAY_TASK_ID}
In=/bighub/hub/DB/refseq_genomic_blast/blast_refseq_genomic_v4/targz/list/listTarGz-split-$nb

for i in $(cat $In)
  do 
    tar -zxvf $i
  done 


