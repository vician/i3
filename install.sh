#!/bin/bash

readonly BASE_FILE=$(readlink -f $0)

readonly SRC_PATH="$HOME/Documents/src/"
readonly LAYOUT_PATH=${SRC_PATH}xkblayout-state
readonly RS_PATH=${SRC_PATH}i3scripts


function check_repository {
	git remote update
	git status -uno | grep up-to-date
	if [ $? -eq 0 ]; then
		echo " - no changes on remote repository"
		return 0
	else
		return 1
	fi
}



# i3
sudo apt install i3

# i3blocks
sudo apt install i3blocks

# Rofi
sudo apt install rofi

# Additional packages
additionals=("xautolock" "acpi" "lm-sensors" "terminator" "dunst" "feh" "xclip" "inotify-tools" "libpcsclite1" "pcscd" "pcsc-tools" "libxcb-ewmh-dev" "numlockx")
echo "Checking additional packages (${additional[*]}"
for additional in ${additionals[@]}; do
	echo -n "- $additional"
	dpkg -s $additional 1>/dev/null 2>/dev/null
	if [ $? -ne 0 ]; then
		echo " - installing"
		sudo aptitude install $additional
	else
		echo " - already installed"
	fi
done


# i3lock
sudo apt install i3lock

# Keyboard layout
echo "Checking Keyboard layout repository"
if [ ! -d $LAYOUT_PATH ]; then
	echo "- new clone"
	git clone https://github.com/nonpop/xkblayout-state $LAYOUT_PATH
	cd $LAYOUT_PATH
	make
else
	echo "- pull changes"
	cd $LAYOUT_PATH
	git pull
fi

#i3scripts
echo "Checking i3scripts repository"
if [ ! -d $RS_PATH ]; then
	echo "- new clone"
	git clone https://github.com/vician/i3scripts $RS_PATH
else
	echo "- pull changes"
	cd $RS_PATH
	git pull
fi

# Init player file
touch ~/.i3/player
touch ~/.i3/weather_condition

if [ ! -f /etc/udev/rules.d/80-monitor-hotplug.rules ]; then
	#echo ACTION=="change", SUBSYSTEM=="drm", RUN+="/home/$USER/.i3/monitor-hotplug.sh" > /etc/udev/rules.d/80-monitor-hotplug.rules
	echo @TODO
fi

# Restart i3
i3-msg restart
