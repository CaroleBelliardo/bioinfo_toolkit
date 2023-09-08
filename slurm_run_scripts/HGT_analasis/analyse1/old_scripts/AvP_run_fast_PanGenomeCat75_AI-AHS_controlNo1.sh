#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=594G   # memory per Nodes   #38
#SBATCH -J "AvP"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-PgavpCat75_no-%j.err
#SBATCH -o slurm-PgavpCat75_no-%j.out
#SBATCH -p  infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

wd='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/3_avp_cat18P_4_AI_or_HS'
cd $wd

spe_fasta='all18P_prot_cat.faa'
dmd='all18P.dmd'
out2='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/3_avp_cat18P_4_AI_or_HS_missing/'

avpX='pg_sample.groups.yaml'
avpC='pg_fast_sample.config.yaml'

classif='/home/tools/AvP/depot/sample.classificiation_toi_Metazoa.txt'
avp_path='/home/tools/AvP/avp'

ai_out='1-all18P.dmd_ai.out_AIpos_AHSpos_missing1'
out='avp_fastree_75'

#$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
#$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
$SING2 $SING_IMG $avp_path detect --trees $out/fasttree --trees_suffix fasttree -i $out/mafftgroups/ -o $out2 -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
