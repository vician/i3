#!/bin/bash

dir="$HOME/.screenlayout/"

function gen_options() {
	ls $dir
}

selected=$( gen_options | rofi -dmenu -p "Select action:")

echo "selected: $selected"

file="$dir$selected"

if [ -f "$file" ] && [ -x "$file" ]; then
	$file
else
	echo "Unsuported choice!"
fi

echo "Exit"
