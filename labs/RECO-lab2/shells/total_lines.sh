#!/bin/bash
#Verificar que solo haya un argumento
if [ $# -ne 1 ]; then
	echo "Uso: <file>"
	exit 1
fi
path=$1
#Verificar que el archivo exista
if [ ! -e "$path" ]; then
	echo "Error: file does not exist."
	exit 1
fi
#Cuenta la cantidad de lineas
result=$(wc -l < "$path")
echo "Total of lines: $result"
