#!/bin/bash

exec >> /home/martin/.i3/monitor.log 2>&1

date

export DISPLAY=:0
export XAUTHORITY=/home/martin/.Xauthority

 # Read the status of the relevant graphics adapter
if [ "$HOSTNAME" == "remus" ]; then
	read STATUS < /sys/class/drm/card0-HDMI-A-3/status
elif [ "$HOSTNAME" == "pete" ]; then
	read STATUS < /sys/class/drm/card0-HDMI-A-1/status
fi
echo "$HOSTNAME: $STATUS"
if [ "$STATUS" = "connected" ]; then
	/home/martin/.screenlayout/both.sh
else
	/home/martin/.screenlayout/nb-only.sh
fi  
if [ $# -eq 0 ]; then
	i3-msg restart
fi  
