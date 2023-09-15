#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=9     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=120G   # memory per Nodes
#SBATCH -J "blastn"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load singularity/3.5.3 

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools_kraken_blast_diamond_hmmer.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw --bind /lerins/hub:/lerins/hub:rw"

cd /lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/0_proteome/0-proteomes/

in='Mgrami.fasta'
db='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/0_genome/MgramiNR/GCA_014773135.1/ncbi_dataset/data/GCA_014773135.1/protein.faa'


$SING2 $SING_IMG blastp -db $db -query $in -out ${in}_vs_proteinsNR.blast6 -outfmt 6 -num_threads 9
