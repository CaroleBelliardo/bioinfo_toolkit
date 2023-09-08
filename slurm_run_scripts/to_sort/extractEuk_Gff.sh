#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=4     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "busco"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e /work/cbelliardo/zslurm-jobs/slurm-%j.err
#SBATCH -o /work/cbelliardo/zslurm-jobs/slurm-%j.out
#SBATCH -p all

SING_IMG=/bighub/hub/people/carole/work-bighub/sing-image/busco_v4.0.5_cv1.sif
SING2="singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw"

# grab our filename from a directory listing

for i in $(cat mid-split-$SLURM_ARRAY_TASK_ID) ; do grep -wf tetrahymena_${i}.bed.txtmin50PEuk /work/cbelliardo/JGI_metag_untarFile/files/${i}/${i}*gff > list_gene_by_metag_Prodigal/$i ;done
