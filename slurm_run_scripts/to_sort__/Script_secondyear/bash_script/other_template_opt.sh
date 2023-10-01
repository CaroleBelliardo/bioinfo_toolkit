#!/bin/bash
 
function usage(){
	printf "Utilisation du script :\n"
	printf "\t--home                   : affiche le chemin vers le home de l'utilisateur courant ;\n"
	printf "\t--nb_fichiers repertoire : affiche le nombre de fichiers contenus dans le répertoire ;\n"
	printf "\t-h                       : affiche ce message.\n"
}
 
if [ $# -eq 0 ]
then
	usage
fi
 
function showHome(){
	echo "Home de l'utilisateur $USER";
	echo $HOME;
}
 
function nbFichiers(){
	if [ -d $1 ]
	then
		nb=$( ls $1 | wc -l )
		echo "$1 contient $nb fichiers et répertoires."
	else
		echo "Ce n'est pas un répertoire !"
		usage
		exit 0
	fi
}
 
OPTS=$( getopt -o h -l home,nb_fichiers: -- "$@" )
if [ $? != 0 ]
then
    exit 1
fi
 
eval set -- "$OPTS"
 
while true ; do
    case "$1" in
        -h) usage;
            exit 0;;
        --home) showHome;
                shift;;
	--nb_fichiers) echo "Afficher le nombre de fichiers et répertoires dans le répertoire $2";
		nbFichiers $2;
		shift 2;;
        --) shift; break;;
    esac
done
 
exit 0
