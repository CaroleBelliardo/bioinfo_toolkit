#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=4   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes
#SBATCH -J "samt_Rhizo"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/Trinity.sif
BUILD=/bighub/hub/projects/2019_trichogramma/data/trichogramma_mrna # out

SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"
DIR= #in

#Metag_fasta_rep=/bighub/hub/people/adrien-2019/2019_metagenomes/faa_files/
#out=/work/cbelliardo/outputs

while read file
   do  $SING2 $SING_IMG xargs samtools faidx /bighub/hub/people/adrien-2019/2019_metagenomes/faa_files/$file < /bighub/hub/people/carole-2019/work-bighub/Rhizo/Rhizophagus_IMG_seqID >> /work/cbelliardo/outputs/${file}_samt_Rhizo2
   done < /bighub/hub/people/carole-2019/work-bighub/Rhizo/num_paquets_Rhizo




