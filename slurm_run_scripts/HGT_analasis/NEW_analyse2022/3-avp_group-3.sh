#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
#SBATCH -J "a22"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a22-%j.err
#SBATCH -o slurm-a22-%j.out
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/avp'
cd $wd

ai_out='dmd_ai.txt'
spe_fasta='all18P_prot_cat.faa'
dmd='dmd.txt'
#out='fasttree'

avpX='pg_sample.groups.yaml'
avpC='pg_fast_sample.config.yaml'

classif='/work/cbelliardo/bin/AvP/depot/sample.classificiation_toi_Metazoa.txt'
#avp_path='/work/cbelliardo/bin/AvP/avp'
avp_path='/home/tools/AvP/avp'

#firstGroup
#$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC

#Homade groups
out='fasttree2'
#groups='PanG2__newGroup_unionIPR3.tsv'

#$SING2 $SING_IMG $avp_path prepare -y $groups -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
#$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
#$SING2 $SING_IMG $avp_path classify -i $out/fasttree_nexus/ -t ${out}/fasttree_tree_results.txt -f $classif -c $avpC -o $out


gff='/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/7-GFF'
$SING2 $SING_IMG python3 hgt_local_score.py -f ../MEAM1_v1.2_edit.gff3 -a ../btab_ai_ahs_calc_all.out -t ../fasttree_tree_results.txt -m 0 -k 10

#* -f : fichier GFF
#* -a : fichier avec le résultat calcul du score ai et/ou ahs (= fichier Features de Alienness ou fichier …ai.out du calcul de score de AvP) Attention, il faut le fichier avec le calcul pour l’ensemble des gènes et pas filtré pour le score AHS supérieur à 0 par ex: fichier résultat de AvP
#* -m : indiquer 0 pour l’utilisation du format GFF (pas d’autre format disponible actuellement)
#* -k : nombre de gènes avant et après le gène d’intérêt (5 par défaut mais 10 est bien aussi)
#il faut installer le module docopt pour faire tourner le script




