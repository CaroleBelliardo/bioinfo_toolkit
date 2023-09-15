#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=56     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=524G   # memory per Nodes
#SBATCH -J "addCol"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

db_gi_taxid=$1
db_lineage=$2
file=$3
out1=${3}_taxID
out2=${3}_taxID_lineage

#cut -f 2 $file | cut -d'|' -f 2  > gi
#paste $file gi > ${file}_gi
#rm gi
#file2=${file}_gi  
#echo $file2
#awk 'NR==FNR {h[$1] = $0; next} {print $0,h[$13]}' $db_gi_taxid $file2 > $out1
awk 'NR==FNR {h[$1] = $0; next} {print $0,h[$15]}' $db_lineage $out1 > $out2
