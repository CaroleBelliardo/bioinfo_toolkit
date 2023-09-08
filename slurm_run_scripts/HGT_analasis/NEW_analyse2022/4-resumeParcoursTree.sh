#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G   # memory per Nodes   #38
#SBATCH -J "formatFile"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-tree-%j.err
#SBATCH -o slurm-tree-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

path='/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/CONTA/'
$SING2 $SING_IMG python resume_parcourtTree.py ${path}2-data_branchCompo.csv_lineage ${path}2-data_branchCompo.csv_lineage_analysis
