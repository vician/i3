etxkbmap -query!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status --config ~/.i3/i3status.conf | while :
do
        read line
        #LG=$(setxkbmap -query | awk '/layout/{print $2}') 
        LG=$(~/Documents/src/xkblayout-state/xkblayout-state print "%n")
        echo "LG: $LG | $line" || exit 1
        #echo "${line}" || exit 1
done
