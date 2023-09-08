#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "canu2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-canu3-%j.err
#SBATCH -o slurm-canu3-%j.out
#SBATCH -p infinity

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


input='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered'

#$SING2 $SING_IMG jellyfish count --size=64 -t 70 --mer-len=32 /lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered -o /lerins/hub/projects/25_IPN_Metag/Canu/jellyfish/m64244_210509_060411.ccs.fasta_filtered

$SING2 $SING_IMG /home/tools/canu/build/bin/canu -assemble -p first -d /lerins/hub/projects/25_IPN_Metag/Canu/canu3 -pacbio-hifi $input genomeSize=1g minInputCoverage=3 stopOnLowCoverage=3  gridEngineThreadsOption='--cpus-per-task THREADS' maxMemory=500G maxThreads=70
