#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=2     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes   #38
#SBATCH -J "mg"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-stat-%j.err
#SBATCH -o slurm-stat-%j.out
#SBATCH -p all

module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

FILENAME='/lerins/hub/projects/25_IPN_Metag/10Metag/0-cat/cat_10metag.fasta'
out='/lerins/hub/projects/25_IPN_Metag/10Metag/cat_stat_seqkit.txt'

$SING2 $SING_IMG seqkit stats -j 2 $FILENAME >> $out

