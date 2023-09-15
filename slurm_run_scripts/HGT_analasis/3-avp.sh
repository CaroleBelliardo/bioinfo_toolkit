#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=70     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=600G   # memory per Nodes   #38
#SBATCH -J "a23"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-a22-%j.err
#SBATCH -o slurm-a22-%j.out
#SBATCH -p infinity

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load singularity/3.5.3

SING_IMG='/database/hub/SINGULARITY_GALAXY/AVP.sif'
SING2='singularity exec  --bind /database/hub:/database/hub'

wd='/kwak/hub/25_cbelliardo/HGT/NEW_analyse/avp'
cd $wd

ai_out='dmd_ai.txt'
spe_fasta='all18P_prot_cat.faa'
dmd='dmd.txt'
out='avp_output'

avpX='pg_sample.groups.yaml'
avpC='pg_fast_sample.config.yaml'

classif='/database/hub/WORKFLOW/AvP/depot/sample.classificiation_toi_Metazoa.txt'

avp_path='/database/hub/WORKFLOW/AvP'


$SING2 $SING_IMG $avp_path prepare -a $ai_out -o $out -f $spe_fasta -b $dmd -x $avpX -c $avpC
$SING2 $SING_IMG $avp_path detect -i $out/mafftgroups/ -o $out -g $out/groups.tsv -t $out/tmp/taxonomy_nexus.txt -c $avpC
$SING2 $SING_IMG $avp_path classify -i $out/fasttree_nexus/ -t ${out}/fasttree_tree_results.txt -f $classif -c $avpC -o $out
