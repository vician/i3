#!/bin/bash

LOCK="i3lock"
LOCK_CMD="-d -f -e --color 000000"
#LOCK="slock"
#LOCK_CMD="/usr/bin/xset dpms force off"

#pkill $LOCK #Always kill previous locked
#pgrep $LOCK
#if [ $? -eq 0 ]; then
#	echo "already locked"
#	exit 0;
#fi

~/.i3/player-control stop # Stop possible playing
~/.i3/layout-default.sh # Change keyboard to English
# lock
$LOCK $LOCK_CMD
