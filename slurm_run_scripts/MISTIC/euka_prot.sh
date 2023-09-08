#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "eukaprot"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a-%j.err
#SBATCH -o slurm-a-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_tools/singularity/MetagAssembler.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


cd $1
#FILES=($(ls -1 *.fasta))
#FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

db='/lerins/hub/DB/NT/NT_kraken/' 
FILENAME="/lerins/hub/projects/25_IPN_Metag/10MetagPool/assembly_hifiasm3_kraken_augustus/hifiasm/cat_rename_header.fasta"
in=$FILENAME
out=${FILENAME}_krak

$SING2 $SING_IMG kraken2 --threads 60 --db $db $in --output $out
