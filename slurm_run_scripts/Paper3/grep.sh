#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes
#SBATCH -J "mg_extract"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/lerins/hub/projects/25_tools/singularity/mmseq2"
SING2="singularity exec --bind /lerins/hub:/lerins/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd /lerins/hub/DB/Metagenomics/NewSoilNR/MetaSoil_NR_Eukprot_v2.taxo_c1_mg_split
FILES=($(ls -1 *))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

ori="/lerins/hub/DB/Metagenomics/MetaSoil_NR_Eukprot_v2.faa"
out=fasta/${FILENAME}

$SING2 $SING_IMG perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' $FILENAME $ori > $out
echo $out

