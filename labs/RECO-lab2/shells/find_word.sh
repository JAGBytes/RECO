#!/bin/bash
#Verificar que sean dos argumentos
if [ $# -ne 2 ]; then
	echo "Uso: <file> <word>"
fi

path=$1
word=$2

results=$(grep -n "$word" "$path")

cont=$(echo "$results" | wc -l)

if [ "$cont" -gt 0 ]; then
	echo "Words found in the following lines:"
	echo "$results"
else
	echo "Not found"
fi

echo "Total of words: $cont"

