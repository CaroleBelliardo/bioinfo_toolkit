#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes
#SBATCH -J "blastn"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load singularity/3.5.3 

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools_kraken_blast_diamond_hmmer.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw --bind /lerins/hub:/lerins/hub:rw"

cd /lerins/hub/projects/25_Metag_PublicData/PAPER1/Review_Sdata/eukrepBenchmark
$SING2 $SING_IMG blastn -db /lerins/hub/DB/NT/NT_blast/nt -query eukrep_res_contigNames_Notvalid.fna -out eukrep_res_contigNames_Notvalid.blast6 -outfmt 6
