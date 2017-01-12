#!/bin/bash

BASE_DIR=$(realpath $(dirname $0))

CONFIG="$BASE_DIR/all.config"
FINAL_CONFIG="$BASE_DIR/config"

if [ ! -f $CONFIG ] ; then
	echo "File $CONFIG not found!"
	exit 1
fi

if [ ! -f $FINAL_CONFIG ] ; then
	echo "File $FINAL_CONFIG not found!"
	exit 1
fi

chmod u=rw $FINAL_CONFIG


COUNT=$(xrandr | grep " connected" | wc -l)
PRIMARY=$(xrandr | grep "connected primary" | awk '{print $1}')

if [ $COUNT -ge 3 ]; then # Three or more outputs
	SECONDARY=$(xrandr | grep " connected" | grep -v $PRIMARY | grep -v LVDS | awk '{print $1}')
	THIRD=$(xrandr | grep " connected" | grep -v $PRIMARY | grep -v $SECONDARY | awk '{print $1}')
else
	SECONDARY=$(xrandr | grep " connected" | grep -v $PRIMARY | awk '{print $1}')
fi

if [ ! "$PRIMARY" ]; then
	echo "Cannot find primary monitor!"
	exit 1
fi

sh_mon_primary="$PRIMARY"
if [ ! "$SECONDARY" ]; then
	SECONDARY="$PRIMARY"
fi
sh_mon_secondary="$SECONDARY"
if [ ! "$THIRD" ]; then
	THIRD="$SECONDARY"
fi
sh_mon_third="$THIRD"

echo "primary: $sh_mon_primary"
echo "secondary: $sh_mon_secondary"
echo "third: $sh_mon_third"

# Verify changes
#diff $CONFIG $FINAL_CONFIG
#read -r -p "Are you sure? [y/N] " response
#case $response in
#    [yY][eE][sS]|[yY]) 
#       echo "Let's go"
#       ;;
#    *)
#	    exit 1
#	  ;;
#esac
#
cp $CONFIG $FINAL_CONFIG

#variables=("sh_w0mon" "sh_w1mon" "sh_wterms" "sh_w7mon" "sh_w8mon" "sh_w9mon" "sh_w10mon" "sh_w11mon" "sh_w12mon" "sh_w13mon")
variables=("sh_mon_primary" "sh_mon_secondary" "sh_mon_third")
for variable in ${variables[@]}; do
	echo -n "- variable $variable = ${!variable} - "
	if [ "${!variable}" ] ; then
		sed -i "s/$variable/${!variable}/g" $FINAL_CONFIG
		if [ $? -ne 0 ]; then
			echo "FAILED!"
		else
			echo "OK"
		fi
	else
		sed -i "s/$variable//g" $FINAL_CONFIG
		echo "EMPTY!"
	fi
done

# Add do not change this file
sed -i "1s/^/##################################\n### DO NOT CHANGE THIS FILE!!! ###\n##################################\n\n/" $FINAL_CONFIG

# MAke config readonly
chmod u=r $FINAL_CONFIG

i3 -C
if [ $? -ne 0 ]; then
	echo "Invalid i3 config!"
	exit 0
fi
#i3-msg restart
#i3-msg reload
