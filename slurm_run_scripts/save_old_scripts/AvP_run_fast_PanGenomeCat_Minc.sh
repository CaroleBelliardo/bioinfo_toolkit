#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=60     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=400G   # memory per Nodes   #38
#SBATCH -J "AvP-minc"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-Pgavp_minc-%j.err
#SBATCH -o slurm-Pgavp_minc-%j.out
#SBATCH -p all

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/3_avp_cat18P_2'
cd $wd

ai_out='FEATURES.xls_minc3'
spe_fasta='all18P_prot_cat.faa'
dmd='all18P.dmd'
out='avp_fastree_onlyMinc3'

avpX='pg_sample.groups.yaml'
avpC='pg_fast_sample.config.yaml'

classif='/home/tools/AvP/depot/sample.classificiation_toi_Metazoa.txt'
avp_path='/home/tools/AvP/avp'

$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
#$SING2 $SING_IMG $avp_path detect --trees $out/fasttree --trees_suffix fasttree -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
$SING2 $SING_IMG $avp_path classify -i $out/fasttree_nexus/ -t ${out}/fasttree_tree_results.txt -f $classif -c $avpC -o $out
#echo 'fasttree ok'


#avpC='pg_iq_sample.config.yaml'
#out2='avp_iqtree'

#$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out2 -g $out/groups.tsv -t $out2/tmp/taxonomy_nexus.txt -c $avpC
#$SING2 $SING_IMG $avp_path classify -i $out2/iqtree_nexus/ -t ${out2}/iqtree_tree_results.txt -f $classif -c $avpC -o $out2


