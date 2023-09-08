#!/bin/bash

# Vérifie les arguments d'entrée
if [ "$#" -ne 3 ]; then
    echo "Usage: sbatch untargz.sh <wd_path> <repo> <output>"
    exit 1
fi

# Définit les variables pour les arguments
wd_path="$1"
repo="$2"
output="$3"

# Soumet ce script avec: sbatch thefilename
#SBATCH --ntasks=1   # nombre de cœurs de processeur (c'est-à-dire de tâches)
#SBATCH --cpus-per-task=1     # nombre de CPU par tâche
#SBATCH --nodes=1   # nombre de nœuds
#SBATCH --mem=8G   # mémoire par nœud
#SBATCH -J "untargz"   # nom de la tâche
#SBATCH --mail-user=carole.belliardo@inra.fr   # adresse e-mail
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -e /work/cbelliardo/slurms/slurm-%j.err
#SBATCH -o /work/cbelliardo/slurms/slurm-%j.out

# CHARGE LES MODULES, INSÈRE LE CODE ET EXÉCUTE TES PROGRAMMES ICI

# -- comprime tous les fichiers du dépôt $repo
cd "$wd_path"
FILES=($(ls -1 "$repo"/*.tar.gz))
PREFS=($(ls -1 "$repo"/*.tar.gz | cut -d'.' -f1))

# Boucle sur les fichiers
for ((i=0; i<${#FILES[@]}; i++)); do
    FILENAME="${FILES[$i]}"
    PREF="${PREFS[$i]}"

    tar -zxvf "$FILENAME" --wildcards --no-anchored "$PREF*fna" "$PREF*faa" "$PREF*.phylodist.txt" "$PREF*.gff"
done

