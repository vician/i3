#!/bin/bash

CURRENT=$(xkblayout-state print "%n")

#echo "currently: $CURRENT"

if [ "$CURRENT" = "English" ]; then
		#echo "switching to Czech"
		setxkbmap -layout cz -variant 'qwerty'
		pkill -SIGRTMIN+12 i3blocks
		exit 0
fi

if [ "$CURRENT" = "Czech" ]; then
		#echo "switching to English"
		setxkbmap -layout us
		pkill -SIGRTMIN+12 i3blocks
		exit 0
fi
