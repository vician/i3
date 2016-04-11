#!/bin/bash

pgrep i3lock
if [ $? -eq 0 ]; then
	echo "already locked"
	exit 0;
fi

#if [ $# -eq 0 ]; then
#	~/.i3/yubi/approved.sh
#	if [ $? -eq 0 ]; then
#		i3-nagbar -t warning -m 'WARNING: Inserted security key, are you sure that you want to lock computer manually?!' -b 'Yes, lock' '/home/sansom/.i3/lock.sh nosmartcard'
#		exit 0
#	fi
#else
#	if [ "$1" = "nosmartcard" ]; then
#		touch ~/.i3/yubi/force.lock
#	fi
#fi

grep gnome-mplayer ~/.i3/player
if [ $? -ne 0 ]; then
	~/.i3/player-control stop # Stop possible playing
fi
setxkbmap -layout us
setxkbmap -layout us,cz
setxkbmap -option 'grp:alt_caps_toggle'
setxkbmap -variant ',qwerty'
i3lock -e --color 000000 # lock
