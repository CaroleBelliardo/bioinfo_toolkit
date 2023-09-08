#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task 16     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=64G   # memory per Nodes
#SBATCH -J "makedb"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


cd /bighub/hub/DB/ensembl_genome_20200130/blast_ensembl_genome_20200130
bioawk -c fastx '!(seq in a){print; a[seq]}' ensembl_genome_20200130.out > ensembl_genome_20200130.out2
#/bighub/hub/people/carole/work-bighub/tools/seqkit rmdup ensembl_genome_20200130 -j 32 -o blast_ensembl_genome_20200130.o
#cat ensembl_genome_20200130 | awk -vRS=">" '!a[$0]++ { print ">"$0; }' - > ensembl_genome_20200130.out
#awk 'BEGIN{RS=">"}NR>1{sub("\n","\t"); gsub("\n",""); print RS$0}' ensembl_genome_20200130 | awk '!seen[$0]++' | awk -v OFS="\n" '{for(i=2;i<NF;i++) head = head " " $i; print $1 " " head,$NF; head = ""}' > ensembl_genome_20200130.out
#grep '>' ensembl_genome_20200130.out > ensembl_genome_20200130_seqID.out
#wc -l ensembl_genome_20200130_seqID.out > ensembl_genome_20200130_seqID_uniq_count.out
#sort ensembl_genome_20200130_seqID.out |uniq -c |sort > ensembl_genome_20200130_seqID_uniqc_sort.out
#wc -l ensembl_genome_20200130_seqID_uniqc_sort.out >> ensembl_genome_20200130_seqID_uniq_count.out

#sh ./remove_duplicate_sequence.shx -f ensembl_genome_20200130 -o ensembl_genome_20200130.out

#SING_IMG=/home/singularity/images/blast_2.9.sif
#SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

#$SING2 $SING_IMG makeblastdb -dbtype nucl -in ensembl_genome_20200130.out -parse_seqids -taxid_map nucl.accTaxid 

