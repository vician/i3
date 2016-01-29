#!/bin/bash

readonly APPROVED="$HOME/.i3/yubi/approved.txt"
readonly SCAN="$HOME/.i3/yubi/scanning.txt"
readonly LOCKED="$HOME/.i3/yubi/yubi-locked"

if [ $(pidof pcsc_scan) ]; then
       echo pcsc_scan is running
else
       pcsc_scan -n > $SCAN &
fi

while inotifywait $SCAN

do

tail -n 3 $SCAN | grep "$(cat $APPROVED)"

if [ $? == 0 ]; then
	if [ -f $LOCKED ]; then
	        echo unlocked
	        pkill i3lock
		rm $LOCKED
	fi
else
        tail -n 3 $SCAN | grep removed
	pgrep i3lock
	if [ $? -ne 0 ]; then
	        if [ $? == 0 ]; then
			touch $LOCKED
			~/.i3/lock.sh
	        fi
	fi
fi
done
