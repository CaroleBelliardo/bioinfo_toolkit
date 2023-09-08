#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes   #38
#SBATCH -J "pg"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mg-%j.err
#SBATCH -o slurm-mg-%j.out
#SBATCH -p all

module load singularity/3.5.3


### MAIN -------------------------------------------------

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

cd '/lerins/hub/projects/25_IPN_Metag/10MetagPool/reads_fasta' 
FILES=($(ls -1 *.fasta))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

wd='/lerins/hub/projects/25_IPN_Metag/10MetagPool/reads_fasta/Prodigal'


#$SING2 $SING_IMG prodigal -f gff -p anon -i $FILENAME -o ${wd}
$SING2 $SING_IMG prodigal -i $FILENAME -o ${wd}/${FILENAME}_genes -a ${wd}/${FILENAME}_proteins -p meta


