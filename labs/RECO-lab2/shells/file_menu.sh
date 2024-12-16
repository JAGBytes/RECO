#!/bin/bash

#Limpiamos pantalla
clear
#Despliegue el menpu hasta que el usuario salga
option=0;
while [ $option != 3 ]; do
echo "1) Order files"
echo "2) Show files with an specific word"
echo "3) Exit"
read option
clear
if [ $option != 3 ]; then
read -p "Enter the path: " directory
case $option in
	1) 
		./list_files.sh "$directory"
		;;
	2)	./find_dir.sh "$directory"
		;;
	*)
		echo "Opcion no valida"
		;;
esac
fi
done
