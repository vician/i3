#!/bin/bash

if [ $# -eq 1 ] && [ "$1" == "default" ]; then
	current="Czech"
else
	current=$(xkblayout-state print "%n")
fi

#echo "currently: $current"

if [ "$current" = "English" ]; then
		#echo "switching to Czech"
		setxkbmap -layout cz -variant 'qwerty'
		pkill -SIGRTMIN+12 i3blocks
		exit 0
fi

if [ "$current" = "Czech" ]; then
		#echo "switching to English"
		setxkbmap -layout us
		pkill -SIGRTMIN+12 i3blocks
		exit 0
fi
