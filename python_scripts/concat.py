import os
import sys

# Spécifiez le chemin du répertoire contenant les fichiers à concaténer
repertoire = sys.argv[1]


# Initialiser une chaîne vide pour stocker le contenu concaténé
contenu_concatene = ''

# Parcourir les fichiers dans le répertoire
for fichier in os.listdir(repertoire):
    chemin_fichier = os.path.join(repertoire, fichier)
    if os.path.isfile(chemin_fichier):
        with open(chemin_fichier, 'r') as f:
            contenu_fichier = f.read()
            contenu_concatene += '_________***' + fichier + '\n' + contenu_fichier

# Écrire le contenu concaténé dans un nouveau fichier
with open('concatene.txt', 'w') as resultat:
    resultat.write(contenu_concatene)
