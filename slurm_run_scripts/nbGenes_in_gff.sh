#!/bin/bash

# Utilisation: sbatch nbGenes_in_gff.sh <chemin_du_repo> <valeur_variable_1> <valeur_variable_2> ...

#SBATCH --ntasks=1   # nombre de cœurs de processeur (tâches)
#SBATCH --cpus-per-task=1     # nombre de CPU par tâche
#SBATCH --nodes=1   # nombre de nœuds
#SBATCH --mem=8G   # mémoire par nœud
#SBATCH -J "nbg"   # nom de la tâche
#SBATCH --mail-user=carole.belliardo@inra.fr   # adresse e-mail
#SBATCH --mail-type=ALL
#SBATCH --gid=bioinfo
#SBATCH -p all
#SBATCH -e /work/cbelliardo/slurms/slurm-%j.err
#SBATCH -o /work/cbelliardo/slurms/slurm-%j.out

# Charger des modules, insérer du code et exécuter vos programmes ici

# Définir des variables
REPO_PATH="$1"
VAR1="$2"
VAR2="$3"
# Ajoutez plus de variables au besoin

# Naviguer vers le répertoire du repo
cd "$REPO_PATH"

# Exemple de traitement avec les variables
# /work/cbelliardo/bin/nb_dubLinC -f "$FILENAME" -n 1 -o count_gene/
# /work/cbelliardo/bin/cat_col -f "$FILENAME" -d ../count_gene/"${PREF}"_nb -K "$VAR2" -V "$VAR1" -k "$VAR1" -o '../len_gene/'

# Naviguer vers le répertoire len_gene
# cd '../len_gene/'

# Exemple d'utilisation de variables pour un fichier en entrée
# awk ' $2 >= 1000 || $3 >= 3' "$FILENAME" > ../len_gene_filtering_1000pb_3g/"${PREF}"_1000pb_3g.txt

# Chemin vers l'image Singularity
SING_IMG="/database/hub/SINGULARITY_GALAXY//MetagTools_kraken_blast_diamond_hmmer.sif"
SING2="singularity exec --bind /kwak/hub:/kwak/hub:rw --bind /bighub/hub:/bighub/hub:rw --bind /work/cbelliardo:/work/cbelliardo:rw "

# Exemple d'utilisation de variables pour des chemins
cut -f1 "$FILENAME" > seqlist/"$FILENAME"
$SING2 $SING_IMG /work/cbelliardo/bin/extractListofSeq_perl -l seqlist/"$FILENAME" -f ../../fna/"${PREF}".a.fna -o fasta/

# Exécutez le code avec des variables passées en argument
# Utilisation: sbatch nbGenes_in_gff.sh <chemin_du_repo> <valeur_variable_1> <valeur_variable_2> ...

