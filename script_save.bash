#! /bin/bash
#$1 argument qui contient svrd
#$2 argument qui peut contenir l'option ou le nomDossier
#$3 arugment qui contient le nom du dossier s'il y a une option
#Nathan DUNAND

if [ $# = 2 ]
then
    #mode sans options
    echo "sans options"
    if [ -e $2 ]
    then
	echo "fichier a save existe"
	if [ -e $2"_SAVE" ]
	then
	    echo "fichier save deja existant"
	    #parcourir dossier a save et copier que fichier plus récent que copie dans dossier save
	    for file in $2"/"*
	    do
		if [ -e $2"_SAVE/"$(basename $file) ]
		then
		    #fichier existe aussi dans le dossier de save
		    if [ $file -nt $2"_SAVE/"$(basename $file) ]
		    then
			if [ $(stat -c %s $file)>30 ]
			then
			    #fichier > 1Mo
			    echo "Fichier $file > 1Mo, voulez vous le déplacer ? O/N"
			    read
			    if [ $REPLY = 'o' ]
			    then
				cp $file $2"_SAVE"/$(basename $file)
			    fi
			else
			    cp $file $2"_SAVE"/$(basename $file)
			fi
		    fi
		else
		    echo "fichier n'existe pas dans le dossier save"
		   cp $file $2_SAVE
		    #on le copie
		fi
	    done
	else
	    echo "2"
	    cp -r  $2 $2"_SAVE"
	fi
    else
	echo "fichier n'existe pas"
    fi
elif [ $# = 3 ]
then
    #une option
    if [ $2 = '-b' ]
    then
	#mode sauvegarde brute
	echo "sauvegarde brute"
	if [ -e $3 ]
	then
	    #fichier existe on vide le dossier de save
	    if [ -e $3"_SAVE" ]
	    then
		echo "on vide dossier save"
		rm -f -r $3"_SAVE/"*
	    fi
	    if [ -e "."$3"_SAVE" ]
	    then
		echo "on vide dossier cache save"
		rm -f -r "."$3"_SAVE/"*
	    fi
	fi
	
	cp -r $3/* $3"_SAVE"
    elif [ $2 = '-h' ]
    then
	 #mode sauvegarde cachee
	echo "sauvegarde cachee"
	cp -r $3 "."$3"_SAVE"
    else
	echo "erreur syntaxe"
    fi
elif [ $# = 4 ]
then
    #deux options
    if [ $2 = '-b' ] || [ $2 = '-h' ]
    then
	echo "2 options"
    elif [ $2 = '-h' ] || [ $2 = '-b' ]
    then
	echo "2 options"
    else
	echo "erreur syntaxe"
    fi
else
    echo "erreur nombre de parametres"
fi
