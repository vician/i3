#!/bin/bash

readonly BASE_FILE=$(readlink -f $0)

readonly SRC_PATH="$HOME/Documents/src/"
readonly I3_PATH=${SRC_PATH}i3
readonly ROFI_PATH=${SRC_PATH}rofi
readonly LAYOUT_PATH=${SRC_PATH}xkblayout-state
readonly RS_PATH=${SRC_PATH}i3scripts
readonly I3BLOCKS_PATH=${SRC_PATH}i3blocks
readonly I3LOCK_PATH=${SRC_PATH}i3lock

readonly I3BLOCK_COLOR_PATCH="$(dirname $BASE_FILE)/i3blocks-color.patch"

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

## Requirements
# i3
echo "Checking i3 package requirements"
which i3 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "- installing"
	sudo aptitude install libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-xinerama0-dev libpango1.0-dev libxcursor-dev libxcb-cursor-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libx11-xcb
else
	echo "- already installed"
fi

# https://launchpad.net/ubuntu/+source/xcb-util-xrm
# wget "https://launchpad.net/ubuntu/+archive/primary/+files/libxcb-xrm0_1.0-1_amd64.deb"
# sudo gdebi libxcb-xrm0_1.0-1_amd64.deb
# wget "https://launchpad.net/ubuntu/+archive/primary/+files/libxcb-xrm-dev_1.0-1_amd64.deb"
# sudo gdebi libxcb-xrm-dev_1.0-1_amd64.deb

# Building i3
function build_i3 {
	echo "- building i3"
	make
	sudo make install
}
echo "Checking i3 repository"
if [ ! -d $I3_PATH ]; then
	echo "- new clone"
	git clone https://github.com/i3/i3.git $I3_PATH
	cd $I3_PATH
	build_i3
else
	echo "- pulling changes"
	cd $I3_PATH
	check_repository
	if [ $? -ne 0 ]; then
		git pull
		build_i3
	fi
fi

# i3blocks
echo "Checking i3blocks package requirements"
which i3blocks 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "- installing"
	sudo aptitude install ruby-ronn
else
	echo "- already installed"
fi
function build_i3blocks {
	echo "- bulding i3blocks"
	git apply $I3BLOCK_COLOR_PATCH
	make all
	sudo make install
}
echo "Checking i3blocks repository"
if [ ! -d $I3BLOCKS_PATH ] ; then
	echo "- new clone"
	git clone https://github.com/vivien/i3blocks $I3BLOCKS_PATH
	cd $I3BLOCKS_PATH
	build_i3blocks
else
	echo "-pulling changes"
	cd $I3BLOCKS_PATH
	check_repository
	if [ $? -ne 0 ]; then
		git pull
		build_i3blocks
	fi
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

# Building Rofi
function build_rofi {
	echo "- building rofi"
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
	build_rofi
else
	echo "- pulling changes"
	cd $ROFI_PATH
	check_repository
	if [ $? -ne 0 ]; then
		git pull
		build_rofi
	fi
fi

# Building i3lock
function build_i3lock {
	echo "- building i3lock"
	make
	sudo make install
}
sudo apt install libpam0g-dev libxcb-dpms0-dev

echo "Checking i3lock repository"
if [ ! -d $I3LOCK_PATH ]; then
        echo "- new clone"
        git clone https://github.com/i3/i3lock $I3LOCK_PATH
        cd $I3LOCK_PATH
        build_i3lock
else
        echo "- pulling changes"
        cd $I3LOCK_PATH
        check_repository
        if [ $? -ne 0 ]; then
                git pull
                build_i3lock
        fi
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

# Init player file
touch ~/.i3/player

if [ ! -f /etc/udev/rules.d/80-monitor-hotplug.rules ]; then
	#echo ACTION=="change", SUBSYSTEM=="drm", RUN+="/home/$USER/.i3/monitor-hotplug.sh" > /etc/udev/rules.d/80-monitor-hotplug.rules
	echo @TODO
fi

# Restart i3
i3-msg restart
