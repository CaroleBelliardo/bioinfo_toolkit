#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=595G   # memory per Nodes   #38
#SBATCH -J "metaflye"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e /lerins/hub/projects/25_tmp/slurm/slurm-mf-%j.err
#SBATCH -o /lerins/hub/projects/25_tmp/slurm/slurm-mf-%j.out
#SBATCH -p infinity

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


i='/bighub/hub/species/metagenome/MetaNemaHGT/SMRTcell1-poivrhizoE76/m64244_210509_060411.ccs.bam'
b='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fastq'

#$SING2 $SING_IMG samtools bam2fq $i > $b.smt
#$SING2 $SING_IMG samtools rmdup $b.smt $b


##-- assemblage
#in=$b
#out='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs_fa_col1'

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir $out -t 70  --meta

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot -t 70  --meta --keep-haplotypes     

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_1000 -t 70  --meta --keep-haplotypes --min-overlap 1000

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_500 -t 70  --meta --keep-haplotypes --min-overlap 500

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_2500 -t 70  --meta --keep-haplotypes --min-overlap 2500

#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_5000 -t 70  --meta --keep-haplotypes --min-overlap 5000
