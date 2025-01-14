#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=495G   # memory per Nodes   #38
#SBATCH -J "mg"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e /lerins/hub/projects/25_tmp/slurm/slurm-mg-%j.err
#SBATCH -o /lerins/hub/projects/25_tmp/slurm/slurm-mg-%j.out
#SBATCH -p treed

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'


i='/bighub/hub/species/metagenome/MetaNemaHGT/SMRTcell1-poivrhizoE76/m64244_210509_060411.ccs.bam'
b='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fastq'

#$SING2 $SING_IMG samtools bam2fq $i > $b.smt
#$SING2 $SING_IMG samtools rmdup $b.smt $b


##-- assemblage
in=$b
out='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs_fa_col1'

## -- assemblage
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir $out -t 70  --meta
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot -t 70  --meta --keep-haplotypes     
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_1000 -t 70  --meta --keep-haplotypes --min-overlap 1000
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_500 -t 70  --meta --keep-haplotypes --min-overlap 500
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_2500 -t 70  --meta --keep-haplotypes --min-overlap 2500
#$SING2 $SING_IMG flye --pacbio-hifi $in --out-dir ${out}_keepHaplot_5000 -t 70  --meta --keep-haplotypes --min-overlap 5000

#
## -- compo

rawFasta='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta'
assembly=${out}/assembly.fasta
db_kraken='/lerins/hub/DB/RefSeq_genomic/RefSeq_genomic_kraken'
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

out='/lerins/hub/projects/25_IPN_Metag/m64244_210509_060411.ccs.fasta.krak'


#$SING2 $SING_IMG /home/tools/kraken/kraken2 --threads 60 --db $db_kraken --output $out $rawFasta
#$SING2 $SING_IMG /home/tools/kraken/kraken2 --threads 60 --db $db_kraken $assembly --output ${assembly}.krak


##-- prediction prot
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
wd='/lerins/hub/projects/25_IPN_Metag/prodigal/'

$SING2 $SING_IMG prodigal -f gff -p anon -i $rawFasta -o ${wd}/rawP -a ${wd}/rawP_prot -s ${wd}/raw_startCompl 
$SING2 $SING_IMG prodigal -f gff -p anon -i $assembly -o ${wd}/assembly -a ${wd}/ass_prot -s ${wd}/ass_startCompl -w ${wd}/ass_stat

## TODO 
# try GLIMMER -MG ? MetaGeneAnnotator ? 
