#!/bin/bash

readonly SRC_PATH="$HOME/Documents/src/"
readonly I3_PATH=${SRC_PATH}i3
readonly ROFI_PATH=${SRC_PATH}rofi
readonly LAYOUT_PATH=${SRC_PATH}xkblayout-state


## Requirements
# i3
sudo aptitude install libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-xinerama0-dev libpango1.0-dev libxcursor-dev libxcb-cursor-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
# Rofi
sudo aptitude install gcc make autoconf automake pkg-config libxinerama-dev libxft2-dev libpango-dev libpangocairo-dev libcairo-dev libcairo-xlib-dev libglib2.0-dev libx11-dev libstartup-notification-1.0-dev

# Building i3
git clone https://github.com/i3/i3.git $I3_PATH
cd $I3_PATH
make
sudo make install

# Additional packages
sudo aptitude install i3lock i3blocks i3status xautolock acpi lm-sensors terminator

# Building Rofi
git clone https://github.com/DaveDavenport/rofi $ROFI_PATH
cd $ROFI_PATH
autoreconf -i
mkdir build
cd build
../configure
make
sudo make install

git clone https://github.com/nonpop/xkblayout-state $LAYOUT_PATH
cd $LAYOUT_PATH
make
