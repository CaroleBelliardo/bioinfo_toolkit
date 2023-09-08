#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "cc"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-cc-%j.err
#SBATCH -o slurm-cc-%j.out
#SBATCH -p all

dataset='Rhizo T1 T2'
DMD='/lerins/hub/projects/25_Metag_PublicData/PAPER1/Euka_processV3_cat/DMD_krakenEuka-contigs_lineage/'
list='/lerins/hub/projects/25_Metag_PublicData/PAPER1/Euka_processV3_cat/LIST_krakenEuka-contigs/'
out='lineage'

for data in $dataset ; do

  listr=${list}/${data}/
  cd $listr

  FILES=($(ls -1 *.gff))
  PREFS=($(ls -1 *.gff |cut -d'.' -f1))
  FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
  PREF=${PREFS[$SLURM_ARRAY_TASK_ID]}

  dmdf=${DMD}/${data}/${PREF}.dmd
  outf=${listr}/${out}/${PREF}.txt

 awk -v FS='\t' -v OFS='\t' 'NR==FNR {h[$1] = $4; next} {print $0,h[$2]}' $dmdf $FILENAME > $outf 

done 
