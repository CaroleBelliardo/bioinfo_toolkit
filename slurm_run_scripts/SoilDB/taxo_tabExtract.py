#!/usr/bin/env python3

import re
import sys

# Chemin vers le fichier FASTA d'entrée
fichier_fasta = sys.argv[1]

# Chemin vers le fichier de sortie tabulé
fichier_sortie = sys.argv[2]

# Fonction pour extraire le premier et le dernier mot
def extraire_premier_dernier_mot(sequence):
    mots = re.findall(r'\w+', sequence)
    return mots[0], mots[-1]


# Ouvre le fichier FASTA en lecture
with open(fichier_fasta, 'r') as fichier_entree:
    # Ouvre le fichier de sortie en ecriture
    with open(fichier_sortie, 'w') as fichier_sortie:
        fichier_sortie.write(f"{accession}\t{accession.version}\t{taxid}\n{gi}\t")
        for ligne in fichier_entree:
            if ligne.startswith(">"):  # Ligne d'en-tete
                en_tete = ligne.strip()
                sequence = ""
                sequence += ligne.strip()
                premier_mot, dernier_mot = extraire_premier_dernier_mot(sequence)
                fichier_sortie.write(f"{premier_mot}\t{premier_mot}\t{dernier_mot}\n{premier_mot}\t")

