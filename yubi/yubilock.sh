#!/bin/bash

readonly APPROVED="$HOME/.i3/yubi/approved.txt"
readonly SCAN="$HOME/.i3/yubi/scanning.txt"

LINES=$(pgrep yubilock 2>/dev/null | wc -l)
if [ $LINES == "3" ]; then
	echo "yubilock already running ($LINES)"
	exit 0
fi

if [ $(pidof pcsc_scan) ]; then
       echo pcsc_scan is running
else
       pcsc_scan -n > $SCAN &
fi

while inotifywait $SCAN

do

tail -n 3 $SCAN | grep "$(cat $APPROVED)"

if [ $? == 0 ]; then
	echo unlocked
	pkill i3lock
else
        tail -n 3 $SCAN | grep removed
	pgrep i3lock
	if [ $? -ne 0 ]; then
		~/.i3/lock.sh force
	fi
fi
done
