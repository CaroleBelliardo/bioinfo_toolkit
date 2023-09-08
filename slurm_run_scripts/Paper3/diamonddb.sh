#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=264G   # memory per Nodes   #38
#SBATCH -J "dmd NOT"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/lerins/hub/projects/25_tools/singularity/diamond_2.1.6'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

DB="/lerins/hub/DB/Metagenomics/NewSoilNR/FINISH/mgPub_mgLR_nr_wormbase.fasta"
db="/lerins/hub/DB/Metagenomics/MetaSoil_NR_Eukprot_v3.dmd"

$SING2 $SING_IMG diamond makedb -p 20 --in $DB -d $db
