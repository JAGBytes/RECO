#!/bin/bash
#Verificamos que hayan dos argumentos
if [ $# -ne 2 ]; then
	echo "Uso: $0 <path_file> <number>"
	exit 1
fi

path=$1
number=$2
if [ ! -e "$path" ]; then
	echo "Error: The file does not exist."
	exit 1
fi

tail -n "$number" "$path" | less
