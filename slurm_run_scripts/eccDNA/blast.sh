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

# Load necessary modules
module purge
module load singularity/3.5.3

# Set the path to the Singularity image
SING_IMG='/database/hub/SINGULARITY_GALAXY/blast_2.9.sif'

# Set the command to execute Singularity with the necessary bind mount
SING2='singularity exec --bind /kwak/hub'

# Change to the directory containing the input FASTA file
cd /kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/

# Set the path to the input FASTA file and the name of the BLAST database to create
fasta='/kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/all_Minc.fasta'
db='all_Minc'

# Create the BLAST database (commented out since it has already been created)
#$SING2 $SING_IMG makeblastdb -in $fasta -parse_seqids -blastdb_version 5 -dbtype nucl -out $db
#echo 'db ok'

# Set the path to the query FASTA file and the name of the output file
query='motif/new-motif-2-3-1-noN.fa'
out='new-motif-2-3-1-noN__vs__reads.dmd'

# Run BLAST with the specified parameters
$SING2 $SING_IMG blastn -db $db -query $query -out $out.maxT -outfmt 6 -num_threads 60 -max_target_seqs 60285760
echo 'blast ok'
