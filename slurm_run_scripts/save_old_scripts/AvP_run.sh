#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=595G   # memory per Nodes   #38
#SBATCH -J "AvP"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e /lerins/hub/projects/25_tmp/slurm/slurm-avp-%j.err
#SBATCH -o /lerins/hub/projects/25_tmp/slurm/slurm-avp-%j.out
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_MetaNema/4-AvP_run1'
config_path='/lerins/hub/projects/25_IPN_MetaNema/4-AvP_run1/AvP_config/'

cd $wd
ai_out='MetaNemaHGT_0316_allhgt_alienness_FEATURES.xls'
spe_fasta='meloidogyne_incognita.v3.2015.faa'
dmd='meloidogyne_incognita.v3.dmd'
out='avpPrepare_out_iqTree'

avpX=${config_path}sample.groups.yaml
avpC=${config_path}sample.config.yaml
classif='/home/tools/AvP/depot/sample.classificiation_toi_Metazoa.txt'

avp_path='/home/tools/AvP/avp'
#$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
#$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
$SING2 $SING_IMG $avp_path classify -i $out/iqtree_nexus/ -t ${out}/iqtree_tree_results.txt -f $classif -c $avpC -o $out
#echo $FILENAME 'AvP detect run ending'

