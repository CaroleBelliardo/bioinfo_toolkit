#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=124G   # memory per Nodes   #38
#SBATCH -J "getseq"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e slurm-%j.err
#SBATCH -o slurm-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

bash_scriptsP=/work/cbelliardo/Script_secondyear/bash_script/
script=extractListofSeq_perl.sh
SING_IMG="/lerins/hub/projects/25_20191015_Metag_PublicData/tools_metagData/Singularity/MetagTools_kraken_blast_diamond_hmmer.sif"
SING2="singularity exec --bind /lerins/hub:/lerins/hub:rw --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw "

## several files
#get input : repo with list files

#mkdir /lerins/hub/projects/25_20191015_Metag_PublicData/Mgnify/ftp/SOIL_ParsedData
cd $2
FILES=($(ls -1 *$4 |cut -d'.' -f1 ))
F=${FILES[$SLURM_ARRAY_TASK_ID]}

l=$1 # list : one file 
f=$2/${F}.$4 # repo path
o=$3/${F}.$4 # repo path

$SING2 $SING_IMG ${bash_scriptsP}/${script} -l $l -f $f -o $o
