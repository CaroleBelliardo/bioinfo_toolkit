#!/bin/bash

# Usage: sbatch untar.sh <chemin_du_repo> <nom_du_fichier_tar.gz>

#SBATCH --ntasks=1          # Nombre de cœurs de processeur (tâches)
#SBATCH --cpus-per-task=34  # Nombre de CPU par tâche
#SBATCH --nodes=1           # Nombre de nœuds
#SBATCH --mem=296G          # Mémoire par nœud
#SBATCH -J "untar"          # Nom de la tâche
#SBATCH --mail-user=carole.belliardo@inra.fr  # Adresse e-mail pour les notifications
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo

# Variables
REPO_PATH=$1              # Chemin du répertoire
TAR_FILE=$2               # Nom du fichier tar.gz

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

##-- Décompresser tous les fichiers du répertoire $REPO_PATH
cd $REPO_PATH
tar xvf $TAR_FILE

## Exécuter le code ici

# Exécuter le script avec les valeurs des variables en arguments
# Usage : sbatch untar.sh <valeurvariable1> <valeurvariable2>
# Ajoutez ici la commande pour exécuter votre code

#sbatch untar.sh <REPO_PATH> <TAR_FILE>
