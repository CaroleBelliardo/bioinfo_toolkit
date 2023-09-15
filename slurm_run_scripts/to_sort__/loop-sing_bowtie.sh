#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=4   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes
#SBATCH -J "Bowtie_al"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/MapTools.sif
#BUILD= # out

SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"
DIR=/bighub/hub/people/carole/work-bighub/2-Ident-CMA_mapping/CMA-seq_db/Genome

#out=/work/cbelliardo/outputs

#$1 = file to the script for loop 
#$2 = file 1 paired read
#$3 = file 2 paired read

while read BANK
  do 
    #$SING2 $SING_IMG bowtie2-build  --threads 32 ${DIR}/${BANK}'.fna' ${DIR}/$BANK
    $SING2 $SING_IMG bowtie2 -x ${DIR}/$BANK -1 '/bighub/hub/people/carole/work-bighub/0-data/MetaG/JGI/GraSoiAngelo_159/QC_Filtered_Raw_Data/10041.1.146250.GTTTCG.anqdpht.fastq' -2 '/bighub/hub/people/carole/work-bighub/0-data/MetaG/JGI/GraSoiAngelo_159/QC_Filtered_Raw_Data/9273.1.127221.GTGAAA.anqdp.fastq' -S ${DIR}/${BANK}.sam
done < $1
