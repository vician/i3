#!/bin/bash

CONFIG="./all.config"
FINAL_CONFIG="./config"

if [ ! -f $CONFIG ] ; then
	echo "File $CONFIG not found!"
	exit 1
fi

if [ ! -f $FINAL_CONFIG ] ; then
	echo "File $FINAL_CONFIG not found!"
	exit 1
fi

diff $CONFIG $FINAL_CONFIG
read -r -p "Are you sure? [y/N] " response
case $response in
    [yY][eE][sS]|[yY]) 
       echo "Let's go"
       ;;
    *)
	    exit 1
	  ;;
esac

cp $CONFIG $FINAL_CONFIG


if [ $HOSTNAME == "remus" ]; then
	OUTPUT_DEFINITION='set $min LVDS1\nset $mex HDMI3'
	TRAY_OUTPUT=''
elif [ $HOSTNAME == "pete" ]; then
	OUTPUT_DEFINITION='set $min LVDS1\nset $mex HDMI3'
	#TRAY_OUTPUT='tray_output $min'
	TRAY_OUTPUT=''
else
	echo "Unknown hostname!"
	exit 1
fi


if [ "$OUTPUT_DEFINITION" ]; then
	# Add new lines behind OutputDefiniton
	sed -i "/OutputDefiniton/a $OUTPUT_DEFINITION" $FINAL_CONFIG
else
	echo "Skipping OutputDefiniton..."
fi


if [ "$TRAY_OUTPUT" ]; then
	# Add new line beind TrayOutput
	sed -i "/TrayOutput/a $TRAY_OUTPUT"  $FINAL_CONFIG
else
	echo "Skipping TrayOutput..."
fi

# Add do not change this file
sed -i "1s/^/##################################\n### DO NOT CHANGE THIS FILE!!! ###\n##################################\n\n/" $FINAL_CONFIG
