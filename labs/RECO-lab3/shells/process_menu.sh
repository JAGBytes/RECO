#!/bin/bash

option=0;

while [ $option != 5 ]; do
#Mostrar menu al usuario
echo "1) List Running Proccesses"
echo "2) Search a process"
echo "3) Kill/Close a process"
echo "4) Reload a process"
echo "5) Exit"
read option 
clear
if [ $option != 5 ]; then
	case $option in 
		1) #Listar los procesos en un momento dado
			ps aux | awk '{print $2," ",$3," ",$4," ",$11}' | less
			;;
		2) #Buscar un proceso
			read -p "Enter the process name: " name
			#Verificar que el nombre proporcionado sea valido
			if [ -z "$name" ]; then
				echo "Please, enter a valid name process"
			else
				ps -ef | grep "$name" | less
			fi
			;;
		3) #Matar un proceso en ejecucion
			read -p "Enter process ID (If you don't remember, press enter): " id
			if [ -z "$id" ]; then	
				read -p "Enter the name process to kill: " name
				if [ -z "$name" ]; then
					echo "Please, enter a valid name processes"
				else
					#Matar el proceso por el nombre
					pkill "$name"
					verify_name=$(ps -ef | grep "$name" | grep -v grep)
					if [ -z "$verify_name" ]; then
						echo "Process $name killed"
					else
						echo "Cannot killed $name"
					fi 
				fi
			else
			#Matar el proceso por el id
				kill "$id"
				verify_id=$(ps -p "$id" -o comm=)
				if [ -z "$verify_id" ]; then
					echo "Process $id killed"
				else
					echo "Cannot killed process $id"
				fi
			fi
			;;
		4) #Reiniciar un proceso en ejecucion
			read -p "Enter the ID process to restore (If you don't remember press enter): " id
			if [ -z "$id" ]; then
				read -p "Enter the name process: " name
				#Buscar el id del proceso
				id=$(pgrep -f "$name")
			fi
			clear
			#Verificar que el id sea valido
			if [ -z "$id" ]; then
				echo "Process in execution not found"
			else
			#Guardar el proceso para ejecutarlo despues del kill
				actual_name=$(ps -p "$id" -o cmd=)
				if [[ ! -z "$actual_name" ]]; then
					kill "$id"
					echo "Restarting $id....."
					sleep 1
					echo "..."
					sleep 1
					echo "..."
					eval "$actual_name &"
					new_id=$(pgrep -f "$actual_name")
					echo "Process $actual_name restarted with id $new_id"
				fi
			fi

			;;
		*)
			echo "Invalid option."
			;;
		esac
fi
done
