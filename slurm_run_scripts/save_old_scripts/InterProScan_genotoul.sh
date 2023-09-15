#!/bin/bash
#SBATCH -p workq
#SBATCH -t 4-00:00:00 #Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".
#SBATCH --mem=50G

#Purge any previous modules
module purge

#Need Java 12, Python3
module load system/jdk-12.0.2 system/Python-3.6.3

module load bioinfo/interproscan-5.51-85.0

echo "Standalone mode"

interproscan.sh -i ~/work/Proteome/orthofinder/Ppene.fasta -b Ppene -dp -f TSV -iprlookup  -goterms -pa

