#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes
#SBATCH -J "kraken"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/lerins/hub/projects/25_tools/singularity/AVP_v2.sif"
SING2="singularity exec --bind /lerins/hub:/lerins/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd /lerins/hub/projects/25_MetaNema/10Metag/kraken_reads
out=lineages

FILES=($(ls -1 *.krak))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
PREFS=($(ls -1 *.krak | cut -f1 -d'.'))
PREF=${FILES[$SLURM_ARRAY_TASK_ID]}

$SING2 $SING_IMG awk 'BEGIN { FS = OFS = "\t" }  NR==FNR {h[$1] = $2; next} {print $0,h[$3]}' taxid_lineage.txt $FILENAME > ${out}/$FILENAME

