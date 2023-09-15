#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=30     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=300G   # memory per Nodes
#SBATCH -J "easylinclust"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL



# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/mmseq2.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

faa='/lerins/hub/projects/25_Metag_PublicData/PAPER1/DEPOT/V2/eukaryotic_proteins.aa'
$SING2 $SING_IMG mmseqs easy-linclust $faa ${faa}_query_clust tmp --min-seq-id 0.99  --threads 30 --cov-mode 1 -c 0.9 --cluster-mode 2

faa='/lerins/hub/projects/25_Metag_PublicData/PAPER1/DEPOT/V2/Protein_orphan/orphan_Euka.aa'
$SING2 $SING_IMG mmseqs easy-linclust $faa ${faa}_query_clust tmp --min-seq-id 0.99  --threads 30 --cov-mode 1 -c 0.9 --cluster-mode 2

