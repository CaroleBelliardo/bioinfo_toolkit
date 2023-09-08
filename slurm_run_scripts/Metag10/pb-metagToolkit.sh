#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=496G   # memory per Nodes   #38
#SBATCH -J "pv1"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-pb-%j.err
#SBATCH -o slurm-pb-%j.out
#SBATCH -p infinity

module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/pb-metagToolkit2.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo  --bind /lerins/hub:/lerins/hub'

cd /lerins/hub/projects/25_IPN_Metag/HiFi-MAG-Pipeline


#$SING2 $SING_IMG /home/tools/conda/bin/snakemake  -np --snakefile Snakefile-hifimags --configfile configs/Sample-Config.yaml
#$SING2 $SING_IMG /home/tools/conda/bin/snakemake --dag --snakefile Snakefile-hifimags --configfile configs/Sample-Config.yaml | dot -Tsvg > /lerins/hub/tmp/hifimags_analysis.svg

$SING2 $SING_IMG /home/tools/conda/bin/snakemake --snakefile Snakefile-hifimags --configfile configs/Sample-Config.yaml -j 70 --use-conda #--conda-frontend conda
