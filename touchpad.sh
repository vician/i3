#!/bin/bash

synclient -l 2>/dev/null | grep TouchpadOff | grep 0 1>/dev/null

if [ $? -eq 0 ] ; then # Enabled
	synclient TouchpadOff=1 # let's disable it
else
	synclient TouchpadOff=0 # let's enable it
fi
