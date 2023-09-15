import sys

# Ouvrir le fichier concatene.txt en lecture
with open(sys.argv[1], 'r') as fichier_concatene:
    lignes = fichier_concatene.readlines()

# Initialiser une variable pour stocker le contenu de chaque fichier
contenu_fichier = ""

# Parcourir les lignes du fichier concatene.txt
for ligne in lignes:
    if ligne.startswith("_________***"):
        # Si on rencontre une nouvelle ligne de séparation, créer un nouveau fichier
        if contenu_fichier:
            # Extraire le nom du fichier
            nom_fichier = contenu_fichier.split("***", 1)[1].strip()
            # Écrire le contenu dans le fichier correspondant
            with open(nom_fichier, 'w') as fichier_resultat:
                fichier_resultat.write(contenu_fichier)
            contenu_fichier = ""
    else:
        # Ajouter la ligne au contenu du fichier
        contenu_fichier += ligne

# Écrire le contenu du dernier fichier
if contenu_fichier:
    nom_fichier = contenu_fichier.split("***", 1)[1].strip()
    with open(nom_fichier, 'w') as fichier_resultat:
        fichier_resultat.write(contenu_fichier)
