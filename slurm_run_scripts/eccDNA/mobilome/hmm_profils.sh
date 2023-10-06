#!/bin/bash

# This script is used to run HMMER3.3.2 to search for homologous sequences in a fasta file.
# The script loads the singularity module, sets the input and output files, and runs the hmmsearch command with specified parameters.

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=10    # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=80G   # memory per Nodes
#SBATCH -J "profils_hmm"   # job name
#SBATCH --mail-user=alexandre.ricci@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-profils_hmm-%j.err
#SBATCH -o slurm-profils_hmm-%j.out
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/database/hub/SINGULARITY_GALAXY/hmmer:3.3.2--h87f3376_2"
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw"

cd /kwak/hub/88_azotta/88_Meloidogyne_genomes/data/Nanofilter/mobilome

input_file=new-motif-2-3-1.fa
output_file=new-motif-2-3-1.hmm

#$SING2 $SING_IMG hmmbuild $output_file $input_fileh

#$SING2 $SING_IMG hmmsearch --cpu 10 -E 0.1 new-motif-2-3-1.hmm Minc_mobilome.fasta >  new-motif-2-3-1_vs_Minc_mobilome.out
$SING2 $SING_IMG hmmsearch --cpu 10 -E 0.1 --tblout new-motif-2-3-1_vs_Minc_mobilome.out2 new-motif-2-3-1.hmm Minc_mobilome.fasta
