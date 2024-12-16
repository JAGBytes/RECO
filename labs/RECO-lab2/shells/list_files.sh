#!/bin/bash
#Función para listar los archivos y ordernarlos segun la opcion
directory="${1:-.}"
list_files(){
	local option=$1
	case $option in
	"recent")
	#Ordena por fecha en orden  ascendente
	find "$directory" -type f -name '.*' -o -type f -printf '%TY-%Tm-%Td %p\n' | \
	awk -F' ' '{ files[$1] = (files[$1] ? files[$1] ", " $2 : $2); count[$1]++ } END { for (date in files) print date " " count[date] " files: " files[date] }' | \
	sort -r
	;;
	"oldest")
	#Ordena en orden descendente
	find "$directory" -type f -name '.*' -o -type f -printf '%TY-%Tm-%Td %p\n' | \
	awk -F' ' '{ files[$1] = (files[$1] ? files[$1] ", " $2 : $2); count[$1]++ } END { for (date in files) print date " " count[date] " files(s): " files[date] }' | \
	sort
	;;
	"size-desc")
	declare -A size_groups
	#Ordena de mayor a menor
	while IFS= read -r line; do
		#extrae el tamanio de los archivos
		size=$(stat -c%s "$line")
		size_groups["$size"]+="$line "
	done < <(find "$directory" -type f)
	#Imprime los archivos ordenados por tamanio
	for size in $(echo "${!size_groups[@]}" | tr ' ' '\n' | sort -nr); do
		count=$(echo "${size_groups[$size]}" | wc -w)
		echo "Size $size bytes: $count archivo(s)"
		files=(${size_groups[$size]})
		for file in "${files[@]}"; do
			echo " $file"
		done
		echo ""
	done
	;;
	"size-asc")
	declare -A size_groups
	#Ordena de menor a mayor tamanio
	while IFS= read -r line; do
		#Extrae el tamanio de los archivos
		size=$(stat -c%s "$line")
		size_groups["$size"]+="$line "
	done < <(find "$directory" -type f)
	#Imprime los archivos ordenados
	for size in $(echo "${!size_groups[@]}" | tr ' ' '\n' | sort -n); do
		count=$(echo "${size_groups[$size]}" | wc -w)
		echo "Size $size bytes: $count archivo(s)"
		files=(${size_groups[$size]})
		for file in "${files[@]}"; do
			echo " $file"
		done
		echo ""
	done
	;;
	*)
		declare -A file_types
		declare -A dir_files 
		file_types["directories"]=0
		#Listar archivos y directorios y recorrerlo
		while IFS= read -r line; do
			if [ -d "$directory/$line" ]; then
				((file_types["directories"]++))
				dir_files["directories"]+="$line "
			else
				ext="${line##*.}"
				if [[ "$line" == *.* && "$ext" != "$line" ]]; then
					((file_types["$ext"]++))
					dir_files["$ext"]+="$line "
				fi
			fi
		done < <(ls -A1 "$directory")
		echo "Files and directories in '$directory':"
		for type in "${!file_types[@]}"; do
			count=${file_types[$type]}
			echo "${type^}: $count"
			files=(${dir_files[$type]})
			for file in "${files[@]}"; do
				echo " $file"
			done
			echo ""
		done
	;;
	esac
}

#Menu para elegir una opcion
echo "Choose an option to sort files:"
echo "1) Most recent"
echo "2) Oldest"
echo "3) Size from largest to smallest"
echo "4) Size from smallest to largest"
echo "5) File type"
read choice
#Limpiar pantalla
clear

case $choice in
	1)
		list_files "recent" | less
		;;
	2)
		list_files "oldest" | less
		;;
	3)
		list_files "size-desc" | less
		;;
	4)
		list_files "size-asc" | less
		;;
	5)
		list_files "type" | less
		;;
	*)
		echo "Inavlid choice" 
		;;
esac

