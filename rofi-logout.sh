#!/bin/bash

#BASE_PATH=$(dirname $0)
#
#function gen_workspaces()
#{
#    i3-msg -t get_workspaces | tr ',' '\n' | grep "name" | sed 's/"name":"\(.*\)"/\1/g' | sort -n
#}
#
#
#WORKSPACE=$( (echo empty; gen_workspaces)  | rofi -dmenu -p "Select workspace:")
#
#if [ x"empty" = x"${WORKSPACE}" ]
#then
#    $BASE_PATH/i3_empty_workspace.sh
#elif [ -n "${WORKSPACE}" ]
#then
#    i3-msg workspace "${WORKSPACE}"
#fi

declare -A options
#options["lock"]="/home/martin/.i3/lock.sh"
#options["suspend"]="/home/martin/.i3/suspend.sh"
#options["poweroff"]="poweroff"
#options["logout"]="i3-msg exit"

function add_option() {
	name="$1"
	cmd="$2"
	options[$name]="$cmd"
	echo "$name"
}

function gen_options() {
	add_option lock /home/martin/.i3/lock.sh
 	add_option suspend /home/martin/.i3/suspend.sh
	add_option poweroff poweroff
	add_option logout "i3-msg exit"	
}

echo ${options[@]}

selected=$( gen_options | rofi -dmenu -p "Select action:")


function gen_sure() {
	echo "No"
	echo "Yes"
}

echo "selected: $selected, will do: ${options[$selected]}"


if [ "$selected" == "poweroff" ] || [ "$selected" == "suspend" ]; then
	echo "Asking for sure"
	sure=$( gen_sure | rofi -dmenu -p "Are you sure?!")
	if [ "$sure" != "Yes" ]; then
		echo "Not sure, exiting..."
		exit 0
	fi
fi

$( ${options[$selected]} )

echo "Exit"
