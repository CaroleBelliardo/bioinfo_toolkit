#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes   #38
#SBATCH -J "hifiFilt"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-hifiFilt-%j.err
#SBATCH -o slurm-hifiFilt-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/HiFiAdapterFilt.sif'
SING2='singularity exec --bind /kwak/hub:/kwak/hub'


cd $1 #wd_path 

FILES=($(ls -1 *${2} | cut -d'.' -f1))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

# output dir
output_dir=$3
if [ -d "$output_dir" ]; then
  echo "Le répertoire '$output_dir' existe."
else
  # S'il n'existe pas, le crée
  mkdir "$output_dir"
  if [ $? -eq 0 ]; then
    echo "Le répertoire '$output_dir' a été créé avec succès."
  else
    echo "Erreur : Impossible de créer le répertoire '$output_dir'."
  fi
fi

$SING2 $SING_IMG bash /database/hub/WORKFLOW/HiFiAdapterFilt/pbadapterfilt.sh - -t 20 -o $output_dir

sbatch --array=0-9 '/kwak/hub/25_cbelliardo/MetaNema_LRmg/10Metag/fastq' '.fastq' 'fastq_AdaptFilt'
