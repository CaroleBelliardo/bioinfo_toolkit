#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=124G   # memory per Nodes
#SBATCH -J "nr_format"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/lerins/hub/projects/25_tools/singularity/AVP_v2.sif"
SING2="singularity exec --bind /lerins/hub:/lerins/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd /lerins/hub/DB/Metagenomics/NewSoilNR/FINISH/fasta

$SING2 $SING_IMG python addtaxid_mg10.py 


