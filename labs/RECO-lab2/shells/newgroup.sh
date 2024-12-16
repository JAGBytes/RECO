if [ "$#" -ne 2 ]; then
	echo "Uso: group_name group_id"
	exit 1
fi
name=$1
group_id=$2

#verificar que el grupo no existe
if grep -q "$name" /etc/group; then
	echo "Group already exist."
	exit 1
fi
#anadir grupo con un id
groupadd "$name" --gid "$group_id"
#Verificar que se haya creado
if [ $? -eq 0 ]; then
	echo "Group '"$name"' created successfully"
else
	echo "Could not create '"$name"'"
fi
