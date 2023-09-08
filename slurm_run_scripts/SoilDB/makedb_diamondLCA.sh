#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "soil dmd mkdb"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-dmd_mkdb-%j.err
#SBATCH -o slurm-dmd_mkdb-%j.out
#SBATCH -p all


module load singularity/3.5.3

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

## -- makedb
sing_path='/database/hub/SINGULARITY_GALAXY/'
SING_IMG=$sing_path'diamond:2.1.7--h5b5514e_0'
SING2='singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /database/hub:/database/hub:rw'

cd /database/hub/Metagenomics/MetaSoil_NR_Eukprot_v4

nodes="/database/hub/TAXONOMY/online/nodes.dmp"
names="/database/hub/TAXONOMY/online/names.dmp"
map="MetaSoil_NR_Eukprot_v4.fasta.taxo_"

fasta='MetaSoil_NR_Eukprot_v4.fasta_'
dbout='MetaSoil_NR_Eukprot_v4'

$SING2 $SING_IMG diamond makedb --threads $SLURM_JOB_CPUS_PER_NODE --no-parse-seqids --taxonnodes $nodes --taxonnames $names --taxonmap $map --in $fasta -d $dbout
