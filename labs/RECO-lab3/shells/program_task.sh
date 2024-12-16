#!/bin/bash
#Verificar el numero de argumentos 
if [ $# -ne 2 ]; then
	echo "Uso: <task_name> <periodicity>"
	exit 1;
fi
task=$1
periodicity=$2
#Verificar si la tarea existe
if ! [ -x "$(command -v $task)" ]; then
	echo "Error: the command $task does not exist"
	exit 1
fi

#Agregar la tarea al crontab del usuario
(crontab -l 2>/dev/null; echo "$periodicity $task") | crontab -

echo "Task '$task' programmed with periodicity '$periodicity'"
