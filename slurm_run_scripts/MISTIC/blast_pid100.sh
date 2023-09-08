#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G   # memory per Nodes   #38
#SBATCH -J "a2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a-%j.err
#SBATCH -o slurm-a-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_tools/singularity/blast_2.9.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

cd /lerins/hub/projects/25_IPN_Metag/10Metag/0-cat/Eval_redondance
db='hifiasm3.p_ctg.gfa.fasta'
in='CAT_name.txt'
out='CAT_name.blast100'

$SING2 $SING_IMG blastn -db $db -query $in -out $out -outfmt 6 -num_threads 30 -perc_identity 100
