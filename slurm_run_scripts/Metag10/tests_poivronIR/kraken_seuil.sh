#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=596G   # memory per Nodes
#SBATCH -J "krakenS"   # job name
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



##-- krakenX
#db='/lerins/hub/DB/NR/NR_kraken'
#infile='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.fasta'
#outfile='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.krak'

#$SING2 $SING_IMG kraken2-build --protein --threads 10 --download-taxonomy --db $db
#$SING2 $SING_IMG kraken2-build --protein --threads 10 --download-library nr --db $db
#$SING2 $SING_IMG kraken2-build --protein --threads 70 --build --db $db
#$SING2 $SING_IMG kraken2 --protein --threads 70 --db $db $infile --output $output


##-- Kraken confidence
infile='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.fasta'
output1='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.krak_0.1'
output2='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.krak_0.2'
output3='/lerins/hub/projects/25_IPN_Metag/Kraken/Euka/m64244_210509_060411.ccs.fasta.krak_cut23_sort.taxo_euka.krak_0.3'
db='/lerins/hub/DB/RefSeq_genomic/RefSeq_genomic_kraken'

#$SING2 $SING_IMG kraken2 --confidence 0.1 --threads 60 --db $db --output $output1 $infile
#$SING2 $SING_IMG kraken2 --confidence 0.2 --threads 60 --db $db --output $output2 $infile
#$SING2 $SING_IMG kraken2 --confidence 0.3 --threads 60 --db $db --output $output3 $infile


# all file 
in='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_filtered'
o1='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_krak0.1'
o2='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_krak0.2'
o3='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_krak0.3'

#$SING2 $SING_IMG kraken2 --confidence 0.1 --threads 60 --db $db --output $o1 $in
#$SING2 $SING_IMG kraken2 --confidence 0.2 --threads 60 --db $db --output $o2 $in
#$SING2 $SING_IMG kraken2 --confidence 0.3 --threads 60 --db $db --output $o3 $in

for i in 1 2 3 4 5 6 7 8 9 ;
  do
    echo '---' $i
    seuil=0.0$i
    o4='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta_krak__'$seuil
    $SING2 $SING_IMG kraken2 --confidence $seuil --threads 70 --db $db --output $o4 $in
  done
