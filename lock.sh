#!/bin/bash

pgrep i3lock
if [ $? -eq 0 ]; then
	exit 0;
fi

grep gnome-mplayer ~/.i3/player
if [ $? -ne 0 ]; then
	~/.i3/player-control stop # Stop possible playing
fi
setxkbmap -layout us
setxkbmap -layout us,cz
setxkbmap -option 'grp:alt_caps_toggle'
setxkbmap -variant ',qwerty'
i3lock -e --color 000000 # lock
