#!/bin/bash

# Asigna los argumentos a variables
directorio="$1"
num_archivos="$2"
tamano_max="$3"

if [ "$#" -ne 3 ]; then
    echo "Uso: $0 directorio_arranque #archivos TamanioMax"
    echo "Ejemplo: $0 /home/usuario 10 1000"
    exit 1
fi

# Encuentra los archivos menores al tamanio especificado, los ordena por tamaño y muestra los más pequeños
find "$directorio" -type f -size -${tamano_max}c -print0 | \
    xargs -0 stat --format="%s %n" | \
    sort -n | head -n "$num_archivos" | \
    awk "{ print \"Nombre: \" \$2 \"\nTamanio: \" \$1 \" bytes\" }" 

echo "Mostrados los $num_archivos archivos mas pequenios menores a $tamano_max bytes en $directorio."
echo "Cantidad de archivos encontrados hasta $tamano_max: "
