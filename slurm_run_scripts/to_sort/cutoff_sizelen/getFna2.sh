#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=248G   # memory per Nodes
#SBATCH -J "getF"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo



# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG=/home/singularity/images/Trinity_2.4.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw"

id=${SLURM_ARRAY_TASK_ID}
dataSet=$1
dataJob=${dataSet}_$id


DIR=/work/cbelliardo/4-seuil_cut-Metag
FAA=${DIR}/1-data/$dataSet
OUT=${DIR}/Faa_1000l-3g/$dataJob

listC=/work/cbelliardo/4-seuil_cut-Metag/byPaq/1000l3g/list/$dataJob

mkdir ${OUT}
while read mgL
  do
    mgI=${FAA}/${mgL}/${mgL}.a.fna
    mgO=${OUT}/${mgL}
    perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' ${listC} ${mgI} >> ${mgO}.a.fa
  done < ${FAA}.list_${id}

echo'id'
echo $id
echo'dataSet'
echo $dataSet
echo'dataJob'
echo $dataJob

echo'DIR'
echo $DIR
echo'FAA'
echo $FAA
echo 'OUT'
echo $OUT

echo 'listC'
echo $listC

echo mgI
echo $mgI
echo mgO
echo $mgO

echo 'oo'
echo ${mgO}.a.fa

