#!/bin/bash

# Soumettre ce script avec : sbatch hmmer_hmmsearch.sh <wd_path> <repo> <output>

#SBATCH --ntasks=1   # nombre de cœurs de processeur (c'est-à-dire de tâches)
#SBATCH --cpus-per-task=8     # nombre de CPU par tâche
#SBATCH --nodes=1   # nombre de nœuds
#SBATCH --mem=54G   # mémoire par nœud
#SBATCH -J "hmmer"   # nom du travail
#SBATCH --mail-user=carole.belliardo@inra.fr   # adresse e-mail
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e jobs_slurmFiles/slurm-%j.err
#SBATCH -o jobs_slurmFiles/slurm-%j.out
#SBATCH -p all

# Modules à charger (si nécessaire)

# Variables
SING_IMG="/database/hub/SINGULARITY_GALAXY/MetagTools3.8.sif"
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw "
wd_path="$1"
repo="$2"
output="$3"
inrepo="/lerins/hub/DB/Metagenomics/rawData/JGI_IMGM/${wd_path}/fna/"
outrepo="/work/cbelliardo/amf/metab_insilico/set2/${repo}/"
profils="/lerins/hub/DB/AMF/AMF_markers_genebank_Maajam_Silva/Maarjam/2_clusters_seq_1/split_par_marker_seq_cultured/profils_manualAlg.hhmp"

# Se déplacer dans le répertoire d'entrée
cd "$inrepo"

# Liste des fichiers d'entrée
FILES=($(ls -1 *.fna))

# Nom du fichier en cours de traitement
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

# Chemin complet du fichier de sortie
FILEOUT="${outrepo}${FILENAME}"

# Exécuter HMMER avec Singularity
$SING2 $SING_IMG hmmsearch --cpu 4 --tblout "${FILEOUT}.tb" -o "${FILEOUT}.out" --domtblout "${FILEOUT}tbdom" "$profils" "$FILENAME"

# Exécuter d'autres commandes si nécessaire

# Exécution du code avec les arguments fournis
# sbatch hmmer_hmmsearch.sh "$wd_path" "$repo" "$output"

