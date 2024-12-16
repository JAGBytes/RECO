#!/bin/bash

#Limpiamos pantalla
clear
#Despliegue el menpu hasta que el usuario salga
option=0;
while [ $option != 3 ]; do
echo "1) Show last 15 lines"
echo "2) Show 15 lines with an specific word"
echo "3) Exit"
read option
clear
if [ $option != 3 ]; then
case $option in
	1)	#Iterar sobre los 3 archivos y mostrar 
		for log_file in /var/log/syslog /var/log/messages /var/log/dmesg; do
			echo "Last 15 lines of '"$log_file"'" 
			tail -n 15 "$log_file" | less 
		done 
		;;
	2)	#iterar sobre los 3 archivos, filtrar por la palbra y mostrar
		read -p "Enter the word: " word
		for log_file in /var/log/syslog /var/log/messages /var/log/dmesg; do
			echo "Lines with the word '"$word"' in '"$log_file"'"
			tail -n 15 "$log_file" | grep "$word" | less
		done
 
		;;
	*)
		echo "Opcion no valida"
		;;
esac
fi
done
