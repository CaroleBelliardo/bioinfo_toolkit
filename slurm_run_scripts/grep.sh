#!/bin/bash

# Assurez-vous d'appeler ce script avec : sbatch grep.sh <wd_path> <repo> <output>

#SBATCH --ntasks=1               # nombre de cœurs du processeur (c'est-à-dire les tâches)
#SBATCH --cpus-per-task=1        # nombre de CPU par tâche
#SBATCH --nodes=1                # nombre de nœuds
#SBATCH --mem=8G                 # mémoire par nœud
#SBATCH -J "untargz"             # nom de la tâche
#SBATCH --mail-user=carole.belliardo@inra.fr # adresse e-mail
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all

# CHARGER LES MODULES SI NÉCESSAIRE

# CHEMIN DU RÉPERTOIRE DE TRAVAIL
wd_path="$1"

# RÉPERTOIRE À ARCHIVER
repo="$2"

# DOSSIER DE SORTIE POUR LES FICHIERS TAR.GZ
output="$3"

# SE DÉPLACER VERS LE RÉPERTOIRE DE TRAVAIL
cd "$wd_path"

# LISTE DES FICHIERS DANS LE RÉPERTOIRE
FILES=($(ls -1 "$repo"))

# BOUCLE SUR LES FICHIERS POUR LES ARCHIVER EN TAR.GZ
for FILENAME in "${FILES[@]}"; do
    # Créer l'archive tar.gz pour chaque fichier
    tar zcvf "${output}/${FILENAME}.tar.gz" "$repo/$FILENAME"
done

# EXÉCUTER LE CODE
sbatch grep.sh "$wd_path" "$repo" "$output"

