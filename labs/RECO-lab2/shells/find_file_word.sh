#!/bin/bash
#Comprobar que hayan dos argumentos
if [ $# -ne 3 ]; then
	echo "Uso: <path> <file_name> <word>"
fi

path=$1
file_word=$2
word=$3
#Encontrar archivos que contengan la palabra
results=$(find "$path" -type f -name "*$file_word*") 
#Iterar sobre los archivos encontrados y filtrar las lineas que contengan la palabra 
for f in $results; do
	finding_word=$(grep -n "$word" "$f")
	total=$(echo "$finding_word" | wc -l)
	echo "File: $f"
	#Verifica si hay almenos una coincidencia con la palabra
	if [ $total -ne 0 ]; then
		echo "$finding_word"
		echo "Total: $total"
	else
		echo "No matches found"
	fi
done

