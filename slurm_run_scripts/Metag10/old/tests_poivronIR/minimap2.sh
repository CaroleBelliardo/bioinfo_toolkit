#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes   #38
#SBATCH -J "minimap"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-mm-%j.err
#SBATCH -o slurm-mm-%j.out
#SBATCH -p infinity

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


input='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered'

#$SING2 $SING_IMG jellyfish count --size=64 -t 70 --mer-len=32 /lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered -o /lerins/hub/projects/25_IPN_Metag/Canu/jellyfish/m64244_210509_060411.ccs.fasta_filtered

#$SING2 $SING_IMG /home/tools/canu/build/bin/canu -assemble -p first -d /lerins/hub/projects/25_IPN_Metag/Canu/canu3 -pacbio-hifi $input genomeSize=4g minInputCoverage=2

#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 40 --force-preovec -o asm $input > asm.log
#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 60 --force-preovec -S -o asm2 $input > 2asm.log
#/lerins/hub/projects/25_Metag_PublicData/tools_metagData/hifiasm-meta/hifiasm_meta -t 60 -S -o asm3 $input > 3asm.log

cd /lerins/hub/projects/25_IPN_Metag/

reads=''
redsRef='reads_m64244_210509_060411.ccs.fasta_filtered.mmi'

hifiasm3='hifiasm_assembly3.fasta'
canu='canu_assembly1.fasta'
MetaF='MetaFlye_assembly1.fasta'


$SING2 $SING_IMG minimap2 -d $redsRef $reads
$SING2 $SING_IMG minimap2 -ax $redsRef $hifiasm3 > $hifiasm3.sam
$SING2 $SING_IMG minimap2 -ax $redsRef $MetaF > $MetaF.sam
$SING2 $SING_IMG minimap2 -ax $redsRef $canu > $canu.sam

$SING2 $SING_IMG samtools view -c  -F 4 -t70 $hifiasm3.sam >$hifiasm3.sam.count
$SING2 $SING_IMG samtools view -c  -F 4 -t70 $MetaF.sam > $MetaF.sam.count
$SING2 $SING_IMG samtools view -c  -F 4 -t70 $canu.sam > $canu.sam.count


