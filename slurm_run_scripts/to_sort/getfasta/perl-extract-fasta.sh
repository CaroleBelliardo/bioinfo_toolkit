#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=1     # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=32G   # memory per Nodes
#SBATCH -J "perl ext"   # job name
#SBATCH --mail-user=carole.belliardo@inra.fr   # email address
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

while read file
   do  perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' /bighub/hub/people/carole-2019/work-bighub/Rhizo/Rhizophagus_IMG_seqID /bighub/hub/people/adrien-2019/2019_metagenomes/faa_files/$file >> /work/cbelliardo/outputs/perl/${file}_perl_Rhizo  
   done < /bighub/hub/people/carole-2019/work-bighub/Rhizo/num_paquets_Rhizo

