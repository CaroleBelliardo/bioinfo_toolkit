#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes   #38
#SBATCH -J "cc"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-cc-%j.err
#SBATCH -o slurm-cc-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


for data in Rhizo T1 T2 ; do
  cd /lerins/hub/projects/25_Metag_PublicData/PAPER1/Euka_processV3_cat/LIST_krakenEuka-contigs/${data}/lineage

  FILES=($(ls -1 *.txt))
  FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

  $SING2 $SING_IMG python /work/cbelliardo/scripts/python/count_lineage_Euka_proka_2.py $FILENAME 
done

