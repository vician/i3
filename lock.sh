#!/bin/bash

LOCK="i3lock"
LOCK_CMD="-d -f -e --color 000000"

~/.i3/player-control stop # Stop possible playing
~/.i3/layout.sh default # Change keyboard to English

# lock
$LOCK $LOCK_CMD
