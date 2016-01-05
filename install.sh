#!/bin/bash

readonly SRC_PATH="$HOME/Documents/src/"
readonly I3_PATH=${SRC_PATH}i3
readonly ROFI_PATH=${SRC_PATH}rofi
readonly LAYOUT_PATH=${SRC_PATH}xkblayout-state
readonly RS_PATH=${SRC_PATH}i3scripts

## Requirements
# i3
echo "Checking i3 package requirements"
which i3 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "- installing"
	sudo aptitude install libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-xinerama0-dev libpango1.0-dev libxcursor-dev libxcb-cursor-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
else
	echo "- already installed"
fi

# Building i3
echo "Checking i3 repository"
if [ ! -d $I3_PATH ]; then
	echo "- new clone"
	git clone https://github.com/i3/i3.git $I3_PATH
	cd $I3_PATH
	make
	sudo make install
else
	echo "- pull changes"
	cd $I3_PATH
	git pull
fi

# Rofi
echo "Checking Rofi package requirements"
which rofi 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "- installing"
	sudo aptitude install gcc make autoconf automake pkg-config libxinerama-dev libxft2-dev libpango-dev libpangocairo-dev libcairo-dev libcairo-xlib-dev libglib2.0-dev libx11-dev libstartup-notification-1.0-dev
else
	echo "- already installed"
fi

# Additional packages
echo "Checking additional packages"
which terminator 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "- installing"
	sudo aptitude install i3lock i3blocks i3status xautolock acpi lm-sensors terminator
else
	echo "- already installed"
fi

# Building Rofi
function rofi_build {
	autoreconf -i
	mkdir build
	cd build
	../configure
	make
	sudo make install
}
echo "Checking Rofi repository"
if [ ! -d $ROFI_PATH ]; then
	echo "- new clone"
	git clone https://github.com/DaveDavenport/rofi $ROFI_PATH
	cd $ROFI_PATH
	rofi_build
else
	echo "- pull changes"
	cd $ROFI_PATH
	git pull
fi

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

# Restart i3
i3-msg restart
