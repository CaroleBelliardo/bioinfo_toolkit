#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=596G   # memory per Nodes   #38
#SBATCH -J "cc"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-cc-%j.err
#SBATCH -o slurm-cc-%j.out
#SBATCH -p infinity

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/AVP_v2.sif'
SING2='singularity exec --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'

db='/lerins/hub/DB/HOMELIB/00_alienness/mega_accession2taxid.sort.uniq.sort'
file='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/1-all18P.dmd'
out='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/7-AHS/1-all18P.dmd'
config='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/3-avp_cat18P/pg_sample.groups.yaml'

#awk -v FS='\t' -v OFS='\t' 'NR==FNR {h[$2] = $3; next} {print $0,h[$2]}' $db $file > $out 

$SING2 $SING_IMG python3 /work/cbelliardo/scripts/python/HGT/aux_scripts/calculate_ai.py -i $out -x $config 
