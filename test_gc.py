# Usage: python test_gc.py <string> <int>   
# Options:
#    -h, --help  affiche l'aide

# importation des modules
import sys
import docopt

# définition de la fonction

def main():
    """
    Usage: python test_gc.py <string> <int>   
    """
    # récupération des arguments
    args = docopt.docopt(main.__doc__)
    string = args["<string>"]
    number = args["<int>"]
    # affichage du résultat
    print(string, number)

# appel de la fonction
if __name__ == "__main__":
    main()

