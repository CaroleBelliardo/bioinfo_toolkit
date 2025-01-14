#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=8     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes
#SBATCH -J "taxo"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p all


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG="/lerins/hub/projects/25_tools/singularity/mmseq2"
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

#cd db=/kwak/hub/25_cbelliardo/DB/
#$SING2 $SING_IMG mmseqs databases NR mmseq/nr tmp


cd /lerins/hub/projects/25_MetaNema/10Metag/fasta/Prodigal
FILES=($(ls -1 *_proteins))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]} 

query=$FILENAME
db=/kwak/hub/25_cbelliardo/DB/mmseq/nr
out=/lerins/hub/projects/25_MetaNema/10Metag/fasta/mmseq2_Results/$FILENAME
tmp=tmp_mmseq/${FILENAME}_tmp


#$SING2 $SING_IMG mmseqs createdb $query $query.db
echo 'db ok'
$SING2 $SING_IMG mmseqs taxonomy $query.db $db $out $tmp --tax-lineage 2 #--lca-ranks genus,family,order,superkingdom

