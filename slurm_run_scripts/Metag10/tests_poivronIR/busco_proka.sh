#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=126G   # memory per Nodes   #38
#SBATCH -J "busco"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-busco-%j.err
#SBATCH -o slurm-busco-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/busco.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

cd  /lerins/hub/projects/25_IPN_Metag/assembly_repo

FILES=($(ls -1 *.faa))
PREFS=($(ls -1 * | cut -d'.' -f1))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREF=${PREFS[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG busco -i $FILENAME -o ${PREFS}_proka.busco -m prot -l ./bacteria_odb10 
$SING2 $SING_IMG busco -i $FILENAME -o ${PREFS}_archaea.busco -m prot -l ./archaea_odb10
