#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes
#SBATCH -J "kraken2"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load singularity/3.5.3 


SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw --bind /lerins/hub:/lerins/hub:rw"

db='/lerins/hub/DB/NT/NT_kraken'
infile='/lerins/hub/projects/25_Metag_PublicData/PAPER1/Review_Sdata/eukrepBenchmark/3300031471.a.fna_filtered'
outfile='/lerins/hub/projects/25_Metag_PublicData/PAPER1/Review_Sdata/eukrepBenchmark/3300031471.a.fna_filtered_kraken_new'


#$SING2 $SING_IMG kraken2 --protein --threads 70 --db $db $infile --output $output
$SING2 $SING_IMG kraken2 --threads 70 --db $db $infile --output $output
