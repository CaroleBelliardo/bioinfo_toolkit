#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes   #38
#SBATCH -J "ahs"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-ash-%j.err
#SBATCH -o slurm-ash-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


config='/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/3_avp_fasttree_cat18P_4_AI_or_HS_allRes/pg_sample.groups.yaml'

cd '/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/avp/old_Hgly_Ppene/tmp'
FILES=($(ls -1 *.dmd))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

#-- input FILENAME = dmd output fmt 6 + 13eme colonne [taxid] 
#- utilisation fichier tmp_short_blast_assign modifier avec script python 
#-format_dmdAI.py run sur slurm avec make-dmd.sh
$SING2 $SING_IMG python3 /work/cbelliardo/scripts/python/HGT/aux_scripts/calculate_ai.py -i $FILENAME -x $config 
