#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "Mugsy"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/mugsy.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"
DIR=/bighub/hub/people/carole/work-bighub/2-Ident-CMA_mapping/CMA-seq_db/Genome


$SING2 $SING_IMG mugsy --directory /bighub/hub/people/carole/work-bighub/2-Ident-CMA_mapping/CMA-seq_db/Genome/output_serveur --prefix mygenomes_serveur  ${DIR}/GCA_Diversispora-epigaea.fna ${DIR}/GCA_G-cerebriforme.fna ${DIR}/GCA_O-diaphana.fna ${DIR}/GCA_R-clarus.fna ${DIR}/GCA_R-irregularis.fna ${DIR}/GCA_R_MUCL-43196.fna ${DIR}/GCA_G-rosea.fna

