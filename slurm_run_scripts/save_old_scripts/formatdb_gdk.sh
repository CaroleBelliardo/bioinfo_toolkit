#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=596G   # memory per Nodes   #38
#SBATCH -J "formated"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-avp-%j.err
#SBATCH -o slurm-avp-%j.out
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

f='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/avp_all18P/filtred_MetaSoil_NR_Eukprot_v2.faa'
t='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/avp_all18P/taxid_hits'
o='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/avp_all18P/gdk_formated_filtred_MetaSoil_NR_Eukprot_v2.faa'

#Run a search in blastp mode
$SING2 $SING_IMG python3 /lerins/hub/projects/25_20191015_git/python/nrFormated_gkd.py $f $t > $o
