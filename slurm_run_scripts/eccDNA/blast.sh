#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=400G   # memory per Nodes   #38
#SBATCH -J "blast"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-blast-%j.err
#SBATCH -o slurm-blast-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module purge
module load singularity/3.5.3

SING_IMG='/database/hub/SINGULARITY_GALAXY/blast_2.9.sif'
SING2='singularity exec --bind /kwak/hub'

cd /kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/
fasta='/kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/all_Minc.fasta'
db='all_Minc'

#$SING2 $SING_IMG makeblastdb -in $fasta -parse_seqids -blastdb_version 5 -dbtype nucl -out $db
#echo 'db ok'

query='motif/new-motif-2-3-1-noN.fa'
out='new-motif-2-3-1-noN__vs__reads.dmd'
$SING2 $SING_IMG blastn -db $db -query $query -out $out.maxT -outfmt 6 -num_threads 60 -max_target_seqs 60285760
echo 'blast ok'
