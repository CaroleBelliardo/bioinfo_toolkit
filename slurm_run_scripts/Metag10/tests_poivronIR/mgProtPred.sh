#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=40     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=300G   # memory per Nodes   #38
#SBATCH -J "prodigal"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-pp-%j.err
#SBATCH -o slurm-pp-%j.out
#SBATCH -p treed 

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


input='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_ori'

# contig assembly + read => kraken => sep Euka proka + Prot pred
## -- Quality check 100 pb min
#len='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_len'
#filtred='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtred'

##--len -awk
#cat $input | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' | sed 's/ /\t/' > $len
#awk '$2 > 100' $len | cut -f 1> ${len}_keep
#/lerins/hub/projects/25_20191015_git/bin/extractListofSeq_perl -f $input -l ${len}_keep -o ${input}_filtred ##--perl filtring fasta
#mv ${input}_filtred/$input $filtred

#-- Assembly
#- Flye

#- Canu
#$SING2 $SING_IMG jellyfish count --size=64 -t 70 --mer-len=32 /lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered -o /lerins/hub/projects/25_IPN_Metag/Canu/jellyfish/m64244_210509_060411.ccs.fasta_filtered
#$SING2 $SING_IMG canu -assemble -p first -d canu1 errorRate=0.01 -pacbio-raw $input corMhapSensitivity=high

#- Kraken
#...

# filtre proka
# filtre euka

# --prodigal 
prokFasta='/lerins/hub/projects/25_IPN_Metag/protPrediction/notEuka_seqId.faa'
prokProt='/lerins/hub/projects/25_IPN_Metag/protPrediction/prodigal/notEuka_seqId_notAssembled.gff'
faa='/lerins/hub/projects/25_IPN_Metag/protPrediction/prodigal/notEuka_seqId_notAssembled.faa'
stat='/lerins/hub/projects/25_IPN_Metag/protPrediction/prodigal/notEuka_seqId_notAssembled.stat'

$SING2 $SING_IMG prodigal -i $prokFasta -o $prokProt -f gff -a $faa -p meta #-w $stat 

# -- augustus
#...

