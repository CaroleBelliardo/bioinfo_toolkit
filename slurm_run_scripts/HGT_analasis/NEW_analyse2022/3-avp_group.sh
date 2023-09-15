#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=10     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G   # memory per Nodes   #38
#SBATCH -J "a2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a-%j.err
#SBATCH -o slurm-a-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/avp'
cd $wd

ai_out='dmd_ai.txt'
spe_fasta='all18P_prot_cat.faa'
dmd='dmd.txt'
out='fasttree'

avpX='pg_sample.groups.yaml'
avpC='pg_fast_sample.config.yaml'

classif='/work/cbelliardo/bin/AvP/depot/sample.classificiation_toi_Metazoa.txt'
#avp_path='/work/cbelliardo/bin/AvP/avp'
avp_path='/home/tools/AvP/avp'

#firstGroup
#$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC

#Homade groups
out='fasttree2'
groups='PanG2__newGroup_unionIPR3.tsv'

$SING2 $SING_IMG $avp_path prepare -y $groups -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
#$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
#$SING2 $SING_IMG $avp_path classify -i $out/fasttree_nexus/ -t ${out}/fasttree_tree_results.txt -f $classif -c $avpC -o $out
