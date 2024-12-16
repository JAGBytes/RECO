#!/bin/bash
#Verificar que los argumentos esten completos
if [ "$#" -ne 8 ]; then
	echo "Uso: $0 name group description directory shell user_permissions group permissions other_permissions"
	exit 1
fi
#Desglosar la entrada
name=$1
group=$2
description=$3
directory=$4
shell=$5
user_permissions=$6
group_permissions=$7
others_permissions=$8
#Verificar si el shell existe
if grep -q "$shell" /etc/shells; then
	#Verifica que el grupo exista, si no, lo crea
	if ! grep -q "$group" /etc/group; then
		groupadd "$group"
	fi
	#crear usuario
	useradd -m -d "$directory/$name" -g "$group" -c "$description" -s "$shell" "$name"
	#asignar permisos
	chmod "$user_permissions""$group_permissions""$others_permissions" "$directory/$name"
	
#verificar si el usuario se creo exitosamente
	if id "$name" &>/dev/null; then
		echo "User added correctly"
	else
		echo "User cannot added correctly"
	fi

else
	echo "Shell '"$shell"' does not exist."
fi
