#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "extract"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/home/singularity/images/MapTools.sif
#BUILD= # out

#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"
#DIR=/bighub/hub/people/adrien-2019/2019_metagenomes/TarFilesMetagenomes/downloaded_pack_of_metagenomes/
out=/work/cbelliardo/4-seuil_cut-Metag/

while read file
  do
    tar -zxvf ${file}'.tar.gz' ${file}/README.txt ${file}/${file}.a.fna ${file}/${file}.a.gff
  done < /bighub/hub/people/adrien-2019/2019_metagenomes/TarFilesMetagenomes/downloaded_pack_of_metagenomes/liste_parquets/less_tar${SLURM_ARRAY_TASK_ID}
#tar -zxvf '/bighub/hub/people/adrien-2019/2019_metagenomes/TarFilesMetagenomes/downloaded_pack_of_metagenomes/3300031668.tar.gz' 3300031668/README.txt 3300031668/3300031668.a.fna 3300031668/3300031668.a.gff
