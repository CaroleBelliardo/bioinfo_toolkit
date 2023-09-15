#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=128G   # memory per Nodes
#SBATCH -J "kraken"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

#SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools2.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"
#DBNAME=cmaK
#${SLURM_CPUS_PER_TASK}
nb=${SLURM_ARRAY_TASK_ID}

listmetag=/work/cbelliardo/7-kraken/out/classif_only/euka_taxid/list_metaGeuka/list_metagaGeuka-split-$nb
for i in $(cat $listmetag)
  do 
metagid=$i
fasta=/work/cbelliardo/JGI_metag_untarFile/files/$metagid/$metagid.a.fna 
listseq=/work/cbelliardo/7-kraken/out/classif_only/euka_taxid/euka_seqID_byMetag/$metagid
out=/work/cbelliardo/7-kraken/out/classif_only/euka_taxid/euka_seqID_byMetag_fasta/$metagid.fa
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' $listseq $fasta > $out
  done
