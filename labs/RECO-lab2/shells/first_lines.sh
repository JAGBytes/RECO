#!/bin/bash
#Verificar que solo sea 2 argumentos
if [ $# -ne 2 ]; then
	echo "Uso: <file_path> <number_lines>"
	exit 1
fi

path=$1
number=$2

head -n "$number" "$path" | less
