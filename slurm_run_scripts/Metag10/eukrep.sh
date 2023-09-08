#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=6     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=60G   # memory per Nodes   #38
#SBATCH -J "e"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-eukr-%j.err
#SBATCH -o slurm-eukr-%j.out
#SBATCH -p all

module load singularity/3.5.3


### MAIN -------------------------------------------------

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/Eukrep.sif'
SING2='singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'



## reads
cd /lerins/hub/projects/25_IPN_Metag/10MetagPool/reads_fasta
FILES=($(ls -1 *.fasta))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

echo "$SING2 $SING_IMG Eukrep -i $FILENAME -o ${FILENAME}_eukrep -t 6"



### assembly
cd /lerins/hub/projects/25_IPN_Metag/10MetagPool/assembly_hifiasm3
FILES=($(ls -1 *.fasta)) 
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG Eukrep -i $FILENAME -o ${FILENAME}_eukrep -t 6

