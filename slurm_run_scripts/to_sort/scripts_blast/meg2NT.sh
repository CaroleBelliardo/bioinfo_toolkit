#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16    # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "blastnNT"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG=/home/singularity/images/blast_2.9.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

nb=${SLURM_ARRAY_TASK_ID}
In=/work/cbelliardo/5-Megablast/Split_data1_split2/AllrenameHeader_data1.fa-split-2-split-$nb
out=/work/cbelliardo/5-Megablast/Split_data1_split2/AllrenameHeader_data1.fa-split-2-split-${nb}.blast_nt
#db1=/bighub/hub/DB/refseq_genomic_blast/blast_cma_tax_20200128
#db2=/bighub/hub/DB/refseq_genomic_blast/blast_refseq_genomic

$SING2 $SING_IMG blastn -task megablast -num_threads 22 -max_target_seqs 500 -db "/bighub/hub/DB/blast_cma_tax_20200128/CMA_genomes.fna /bighub/hub/DB/NT/nt" -query $In -out $out -outfmt "6 qaccver saccver pident length mismatch gapopen qstart qendsstart send evalue bitscore ssciname scomnames sgi sskingdoms"


