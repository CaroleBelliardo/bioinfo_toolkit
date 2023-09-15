#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "dmd mkdb"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd_mkdb-%j.err
#SBATCH -o slurm-dmd_mkdb-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
SING_IMG='/database/hub/SINGULARITY_GALAXY/diamond:2.1.7--h5b5514e_0'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /database/hub:/database/hub:rw'

cd $1 # wd

nodes="/database/hub/TAXONOMY/online/nodes.dmp"
names="/database/hub/TAXONOMY/online/names.dmp"
map=$2 #taxid map path

fasta= $3 #fasta input
dbout= $4 #db name

$SING2 $SING_IMG diamond makedb --threads $SLURM_JOB_CPUS_PER_NODE --taxonnodes $nodes --taxonnames $names --taxonmap $map --in $fasta -d $dbout

## run : 
# sbatch diamond_makedb.sh <wd_path> <map_path> <fasta_path> <db_name>
