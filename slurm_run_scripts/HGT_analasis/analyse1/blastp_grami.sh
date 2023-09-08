#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=250G   # memory per Nodes
#SBATCH -J "blastp"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load singularity/3.5.3 

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools_kraken_blast_diamond_hmmer.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw --bind /lerins/hub:/lerins/hub:rw"

cd '/lerins/hub/projects/99_ANR_ALPAGA/00_20211227_GAME_ALPAGA_MINC4_EGN_recipeA/outdir_EGN_MINC4_20211221_recipeA/blastp_db'
map='test_map.txt'

genome='MINC4.20211221.recipeA_prot.fna'
hgt='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/0_proteome/0-proteomes/tmp22'

#$SING2 $SING_IMG makeblastdb -in $genome -parse_seqids -taxid_map $map -title "mgrami" -dbtype prot
$SING2 $SING_IMG blastp -db $genome -query $hgt -out $hgt.blastn6 -outfmt 6 -num_threads 30

