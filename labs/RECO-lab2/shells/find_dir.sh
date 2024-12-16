#!/bin/bash
directory="${1:-.}"
#Mostrar menu
echo "1) Show files with a given start word"
echo "2) Show files with a given last word"
echo "3) Show files wich contains and specific word"
read option
read -p "Write the word: " word
echo "Search on subdirectories? Y/N"
read afirmation
clear

case $option in
1)	
	search="$word*"
	;;
2)
	search="*$word"
	;;
3)
	search="*$word*"
	;;
esac
clear
if [ "$afirmation" = "Y" ]; then
find "$directory" -type f -name "$search" | less
else
find "$directory" -maxdepth 1 -type f -name "$search" | less
fi
	
	
