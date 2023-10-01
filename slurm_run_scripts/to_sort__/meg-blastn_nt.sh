#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1    # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes
#SBATCH -J "NTblastn"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/blast_2.9.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

p=/work/cbelliardo/5-benchmark
In=$p/metag_G-rosea.fa
#In=AllrenameHeader_data1.fa-split-1-split-1
out=${In}.blast


$SING2 $SING_IMG blastn -task megablast -num_threads 1 -max_target_seqs 500 -db "/bighub/hub/DB/CMA/CMA_blast_taxo/CMA_genomes.fna /bighub/hub/DB/NT/nt" -query $In -out $out -outfmt "6 qaccver saccver pident length mismatch gapopen qstart qendsstart send evalue bitscore ssciname scomnames sgi sskingdoms"


