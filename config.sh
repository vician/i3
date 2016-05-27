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
	#OUTPUT_DEFINITION='set $min LVDS1\nset $mex HDMI3'
	sh_w0mon="LVDS1"
	sh_w1mon="HDMI3"
	sh_wterms="HDMI3"
	sh_w7mon="LVDS1"
	sh_w8mon="HDMI3"
	sh_w9mon="LVDS1"
	sh_w10mon="HDMI3"
	sh_w11mon="LVDS1"
	sh_w12mon="LVDS1"
	sh_w13mon="HDMI3"

elif [ $HOSTNAME == "pete" ]; then
	#OUTPUT_DEFINITION='set $min HDMI-1\nset $mex eDP-1'
	sh_w0mon="eDP-1"
	sh_w1mon="eDP-1"
	sh_wterms="eDP-1"
	sh_w7mon="eDP-1"
	sh_w8mon="eDP-1"
	sh_w9mon="eDP-1"
	sh_w10mon="eDP-1"
	sh_w11mon="HDMI-1"
	sh_w12mon="HDMI-1"
	sh_w13mon="eDP-1"
else
	echo "Unknosh_wn hostname!"
	exit 1
fi


variables=("sh_w0mon" "sh_w1mon" "sh_wterms" "sh_w7mon" "sh_w8mon" "sh_w9mon" "sh_w10mon" "sh_w11mon" "sh_w12mon" "sh_w13mon")
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
		echo "EMPTY!"
	fi
done

# Add do not change this file
sed -i "1s/^/##################################\n### DO NOT CHANGE THIS FILE!!! ###\n##################################\n\n/" $FINAL_CONFIG

i3-msg restart
