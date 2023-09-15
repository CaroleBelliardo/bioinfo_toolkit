#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "hifiasm"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-hifiasm-%j.err
#SBATCH -o slurm-hifiasm-%j.out
#SBATCH -p infinity

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


input='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered'

#$SING2 $SING_IMG jellyfish count --size=64 -t 70 --mer-len=32 /lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered -o /lerins/hub/projects/25_IPN_Metag/Canu/jellyfish/m64244_210509_060411.ccs.fasta_filtered

#$SING2 $SING_IMG /home/tools/canu/build/bin/canu -assemble -p first -d /lerins/hub/projects/25_IPN_Metag/Canu/canu3 -pacbio-hifi $input genomeSize=4g minInputCoverage=2

#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 40 --force-preovec -o asm $input > asm.log
#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 60 --force-preovec -S -o asm2 $input > 2asm.log
#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 60 -S -o asm3 $input > 3asm.log


reads=
hifiasm3='/lerins/hub/projects/25_IPN_Metag/hifiasm/run3_SnoForce/asm3.p_utg.gfa.fa'

minimap2 -d ref.mmi ref.fa 

