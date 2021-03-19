#!/bin/bash

clean="\nclean :\n\trm *.c *.out *.o *.py *.java *.class *.tex"
file_name=""

if [ $# = 1 ]
then
    #mode avec uniquement nomFichier
    touch $1
elif [ $# = 2 ]
then
    #mode avec nomFichier & langage
    if [ -e Makefile ]
    then
	#file exist
	echo ""
    else
	#file doesn't exist
	touch Makefile
    fi

    if [ $2 = 'c' ]
    then
	file_name=$1.c
	printf "make :\n\tgcc $file_name\n\t./a.out $clean" > Makefile
	echo '#include <stdio.h>
#include <stdlib.h>
int main(){
printf("hello world !\n");
return 0;
}' > $file_name
    elif [ $2 = 'python' ]
    then
	file_name=$1.py
	printf "make :\n\tpython3 $file_name $clean" > Makefile
	echo 'print("Hello World\n");' > $file_name
    elif [ $2 = 'java' ]
    then
	file_name=$1.java
	printf "make :\n\tjavac $file_name\n\tjava $1 $clean" > Makefile
	printf 'public class '$1' {\n\tpublic static void main(String[] args){\n\t\tSystem.out.println("Hello World");\n\t}\n}\n' > $file_name
    elif [ $2 = 'tex' ]
    then
	e
    fi
    touch $file_name
fi
