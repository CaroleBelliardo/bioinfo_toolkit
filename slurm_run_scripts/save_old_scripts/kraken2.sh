#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=500G   # memory per Nodes
#SBATCH -J "kraken2"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw --bind /lerins/hub:/lerins/hub:rw"

#$SING2 $SING_IMG /home/tools/kraken/kraken2-build --threads 16 --download-taxonomy --db /bighub/hub/DB/NT_kraken/nt
#$SING2 $SING_IMG /home/tools/kraken/kraken2-build --threads 16 --download-library bacteria --db /bighub/hub/DB/NT_kraken/nt
#$SING2 $SING_IMG /home/tools/kraken/kraken2-build --threads 16 --build --db /bighub/hub/DB/NT_kraken/nt
#$SING2 $SING_IMG /home/tools/kraken/kraken2 --threads 8 --db /bighub/hub/DB/NT_kraken/nt metag.fa --output out.krak
#$SING2 $SING_IMG /home/tools/kraken/kraken2 --threads 8 --db /bighub/hub/DB/NT_kraken/nt ../../../5-benchmarkMegablast/Split_data1_split2/AllrenameHeader_data1.fa-split-2-split-1 --output out2.krak
#f=$1
#awk ' $0~">" {a++}{ b=int(a/1000000)+1; print $0 > "splits/"FILENAME"-split-"b}' $f  # fastafile découpe



##-- krakenX
db='/lerins/hub/DB/NR/NR_kraken'
infile='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.fasta'
outfile='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.krak'

#$SING2 $SING_IMG kraken2-build --protein --threads 10 --download-taxonomy --db $db
#$SING2 $SING_IMG kraken2-build --protein --threads 10 --download-library nr --db $db
$SING2 $SING_IMG kraken2-build --protein --threads 70 --build --db $db
$SING2 $SING_IMG kraken2 --protein --threads 70 --db $db $infile --output $output
