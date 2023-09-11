#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=62     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=496G   # memory per Nodes
#SBATCH -J "addLineage"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/MetagTools2.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
#awk ' $0 {a++}{ b=int(a/7779023)+1; print $0 > "all_classf.krak-split/"FILENAME"-split-"b}'  all_classf.krak
#db_lineage=/bighub/hub/DB/ncbi_taxo/al_taxonomy_lineage.txt
#awk '{ FS = OFS = "\t" } NR==FNR {h[$1] = $2 ; next} {print $0,h[$3]}' $db_lineage all_classf.krak-split-${SLURM_ARRAY_TASK_ID} > all_classf.krak-split-${SLURM_ARRAY_TASK_ID}.lineage

#awk -F "\t" '{print $(NF)}' all_classf.krak-split-${SLURM_ARRAY_TASK_ID}.lineage >> all_lineage
#grep -i euka all_classf.krak-split-${SLURM_ARRAY_TASK_ID}.lineage >> euka_lineage
#grep -vi euka all_classf.krak-split-${SLURM_ARRAY_TASK_ID}.lineage >> autre_lineage

awk -F "\t" '{print $(NF)}' euka_lineage > euka_Onlylineage
awk -F "\t" '{print $(NF)}'  autre_lineage autre_Onlylineage
