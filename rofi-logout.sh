#!/bin/bash

function gen_options() {
	echo "lock"
	echo "suspend"
	echo "poweroff"
	echo "reboot"
	echo "reload i3"
	echo "restart i3"
	echo "logout"
	echo "wifi"
}


selected=$( gen_options | rofi -dmenu -p "Select action:")

function gen_sure() {
	echo "No"
	echo "Yes"
}

echo "selected: $selected"

if [ "$selected" == "poweroff" ] || [ "$selected" == "logout" ] || [ "$selected" == "reboot" ]; then
	echo "Asking for sure"
	sure=$( gen_sure | rofi -dmenu -p "Are you sure?!")
	if [ "$sure" != "Yes" ]; then
		echo "Not sure, exiting..."
		exit 0
	fi
fi

if [ "$selected" == "lock" ]; then
	/home/martin/.i3/lock.sh
elif [ "$selected" == "suspend" ]; then
	systemctl suspend
elif [ "$selected" == "poweroff" ]; then
	poweroff
elif [ "$selected" == "reboot" ]; then
	reboot
elif [ "$selected" == "logout" ]; then
	i3-msg exit
elif [ "$selected" == "reload i3" ]; then
	i3-msg reload
elif [ "$selected" == "restart i3" ]; then
	i3-msg restart
elif [ "$selected" == "wifi" ]; then
	gksudo ~/.i3/wpa_supplicant.sh
else
	echo "Unsuported choice!"
fi

echo "Exit"
