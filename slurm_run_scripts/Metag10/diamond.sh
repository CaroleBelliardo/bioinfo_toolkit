#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=424G   # memory per Nodes   #38
#SBATCH -J "dmd"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd-%j.err
#SBATCH -o slurm-dmd-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

db_fasta='/lerins/hub/projects/25_IPN_Metag/10MetagPool/db_diamond_All_10Metag_prots/db_diamond_All_10Metag_prots.aa'
db='/lerins/hub/projects/25_IPN_Metag/10MetagPool/db_diamond_All_10Metag_prots/All_10Metag_prots'

$SING2 $SING_IMG diamond makedb  --in $db_fasta --db $db  -p 30

echo 'make db ok'

## -- Run
QUERY='/lerins/hub/projects/25_IPN_Metag/hgtProt_4643.fasta'
OUT='/lerins/hub/projects/25_IPN_Metag/10MetagPool/hgt/hgtProt_4643.dmd'

#Run a search in blastp mode
$SING2 $SING_IMG diamond blastp --more-sensitive -k500  -p70 --outfmt 6 -d $db -q $QUERY -o $OUT #-b 8 -c 1
# --top 20 --id 25 -b 8 -c 1 

