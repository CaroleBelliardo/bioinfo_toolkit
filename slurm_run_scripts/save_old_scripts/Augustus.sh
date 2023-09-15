#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=20     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=100G   # memory per Nodes   #38
#SBATCH -J "assembly"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-canu-%j.err
#SBATCH -o slurm-canu-%j.out
#SBATCH -p treed

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


input='



/lerins/hub/projects/25_Metag_PublicData/3-AnalysesArticles/test_completness
augustus --uniqueGeneId=true --gff3=on --species={model} {fastaN}.fna  > {gffPath}.gff
