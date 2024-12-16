#!/bin/bash

#Verificar que los argumentos sean correctos
if [ $# -ne 2 ]; then
	echo "Uso: $0 <path> <name_file>"
	exit 1
fi

path="$1"
name="$2"
#Buscar los archivos que coincidan
results=$(find "$path" -type f -name "*$name*")
#Contar el numero de archivos encontrado
cont=$(echo "$results" | wc -l)
#Mostrar los archivos encontrados
if [ "$cont" -gt 0 ]; then
	echo "Files:"
	echo "$results"
else
	echo "Not find files"
fi
#Mostrar total de archivos
echo "Total files: $cont"
