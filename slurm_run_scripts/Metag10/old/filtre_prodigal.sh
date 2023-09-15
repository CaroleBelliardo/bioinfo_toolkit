#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task #4
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=8G   # memory per Nodes   #38
#SBATCH -J "t2"   # job name
#SBATCH --mail-user=carole.belliardo@inrae.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH -e slurm-cc-%j.err
#SBATCH -o slurm-cc-%j.out
#SBATCH -p all

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagTools3.8.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub '

# list_FAAeuk # grep GFF cut -1  = FNAeuk_list
list=$1
cd $list

FILES=($(ls -1 *))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

out=/lerins/hub/projects/25_Metag_PublicData/PAPER1/Euka_processV3_cat/AAeuk_PRODIGAL/

gff_out=${out}/Gffeuk/${3}/${FILENAME}.gff
aa_list=${out}/AAeuk_list/${3}/${FILENAME}.txt
aa=${out}/AAeuk/${3}


gff=/lerins/hub/DB/Metagenomics/0_rawData/JGI_IMGM/${2}/gff/${FILENAME}.a.gff
grep -Ff $FILENAME $gff > $gff_out


cut -f 9 $gff_out | sed 's/;/\n/g' | grep "locus\|ID" | cut -d'=' -f 2 | sort -u   >  $aa_list


fp='/lerins/hub/DB/Metagenomics/0_rawData/JGI_IMGM/'${2}'/faa/'

$SING2 $SING_IMG /work/cbelliardo/scripts/bin/extractListofSeq_perl -l $aa_list -f ${fp}/${FILENAME}.a.faa  -o ${aa}

