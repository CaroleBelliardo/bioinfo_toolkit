#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=48    # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=288G   # memory per Nodes
#SBATCH -J "makedb"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/blast_2.9.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

cd /bighub/hub/DB/blast_refseq_genomic
#cd $1

$SING2 $SING_IMG makeblastdb -dbtype nucl -in refseq_genomic -parse_seqids -taxid_map refseq_genomic_taxid
