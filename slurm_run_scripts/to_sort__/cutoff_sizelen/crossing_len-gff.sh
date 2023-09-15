#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "crossLG"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
DIRlen='/work/cbelliardo/4-seuil_cut-Metag/seqLen'
DIRgff='/work/cbelliardo/4-seuil_cut-Metag/geneNumber'

data=$1
id=${SLURM_ARRAY_TASK_ID}


awk 'NR==FNR {h[$2] = $1; next} {print $0,h[$1]}' ${DIRgff}/${data}_geneNumber_${id}.txt ${DIRlen}/${data}_${id}_20191219.len > '/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff/'${data}'_'${id}

echo $1
echo ${data}
echo ${DIRgff}/${data}_geneNumber_${id}.txt
echo ${DIRlen}/${data}_${id}_20191219.len
echo '/work/cbelliardo/4-seuil_cut-Metag/crossing_len_gff/'${data}'_'${id}
