#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "tar"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools2.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"
#DBNAME=cmaK
#${SLURM_CPUS_PER_TASK}
#${SLURM_ARRAY_TASK_ID}
FILES=($(cat /bighub/hub/people/adrien-2019/2019_metagenomes/TarFilesMetagenomes/downloaded_pack_of_metagenomes/Lleft_h))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

tar --wildcards -zxvf /bighub/hub/people/adrien-2019/2019_metagenomes/TarFilesMetagenomes/downloaded_pack_of_metagenomes/${FILENAME}.tar.gz ${FILENAME}/${FILENAME}.*faa 

