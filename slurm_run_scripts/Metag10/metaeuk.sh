#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "me"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-metaeuk-%j.err
#SBATCH -o slurm-metaeuk-%j.out
#SBATCH -p all
module load singularity/3.5.3


SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

cd /lerins/hub/projects/25_IPN_Metag/10MetagPool/assembly_hifiasm3/

FILES=($(ls -1 *eukrep))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

## -- Metaeuk
input=$FILENAME
db_swp='/lerins/hub/DB/SWISSPROT/SWISSPROT_fasta/swissprot'
#db_me='/lerins/hub/DB/NR/NR_fasta/nr'
meo=${input}__metaeuk_swp
#meo=${input}__metaeuk_nr

tmp='/lerins/hub/projects/25_tmp/'
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'

$SING2 $SING_IMG metaeuk easy-predict --threads 16 $input $db_swp $meo $tmp
