#!/bin/bash

option=0
while [ $option -ne 7 ]; do
	echo "1) Search for file/part of a file given a path and a name/part of a file name."
	echo "2) Search for word/part of a file given a path."
	echo "3) Search for file/part and then search for word/part"
	echo "4) Total of lines of a file"
	echo "5) first n lines of a file"
	echo "6) Last n lines of a file"
	echo "7) Exit"
	read -p "Enter your option: " option
	clear
	if [ $option != 7 ]; then
		case $option in
		1)
			read -p "Enter the path: " path
			read -p "Enter the word: " word
			./find_file.sh "$path" "$word"
			;;
		2)
			read -p "Enter the file path: " path
			read -p "Enter the word: " word
			./find_word.sh "$path" "$word"
			;;
		3)
			read -p "Enter the path: " path
			read -p "Enter the name of the file: " file
			read -p "Enter the word: " word
			./find_file_word.sh "$path" "$file" "$word"
			;;
		4)
			read -p "Enter the file path: " path
			./total_lines.sh "$path"
			;;
		5)
			read -p "Enter the file path: " path
			read -p "Enter the number of lines: " lines
			./first_lines.sh "$path" "$lines"
			;;
		6)
			read -p "Enter the file path: " path
			read -p "Enter the number of lines: " lines
			./last_lines.sh "$path" "$lines"
			;;
		*)
			echo "Invalid option."
			;;
		esac
	fi
done
