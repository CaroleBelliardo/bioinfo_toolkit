#!/bin/bash
SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools_kraken_dmd.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"
SING2="singularity exec"

DBNAME=refseq_kraken

/home/tools/kraken2-master/scripts/kraken2-build --download-taxonomy --db $DBNAME --threads 4

/home/tools/kraken2-master/scripts/kraken2-build --download-library invertebrate --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library bacteria --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library archaea --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library vertebrate_other --db $DBNAME --threads 4 
/home/tools/kraken2-master/scripts/kraken2-build --download-library viral --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library human --db $DBNAME --threads 4 
/home/tools/kraken2-master/scripts/kraken2-build --download-library fungi --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library plant --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library protozoa --db $DBNAME --threads 4
/home/tools/kraken2-master/scripts/kraken2-build --download-library nt --db $DBNAME --threads 4

#$SING2 $SING_IMG /home/tools/kraken2-master/scripts/kraken2-build --build --db $DBNAME --threads 70
