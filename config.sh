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


if [ $HOSTNAME == "remus" ] || [ $HOSTNAME == "duane" ]; then
	mon_prim="HDMI3"
	mon_sec="LVDS1"
	sh_w0mon=$mon_sec
	sh_w1mon=$mon_prim
	sh_wterms=$mon_prim
	sh_w7mon=$mon_sec
	sh_w8mon=$mon_prim
	sh_w9mon=$mon_sec
	sh_w10mon=$mon_prim
	sh_w11mon=$mon_sec
	sh_w12mon=$mon_sec
	sh_w13mon=$mon_prim

elif [ $HOSTNAME == "pete" ]; then
  xrandr | grep eDP-1
	if [ $? -eq 0 ]; then
		mon_prim="eDP-1"
		mon_sec="HDMI-1"
	else
		mon_prim="eDP1"
		mon_sec="HDMI1"
	fi
	sh_w0mon=$mon_prim
	sh_w1mon=$mon_prim
	sh_wterms=$mon_prim
	sh_w7mon=$mon_prim
	sh_w8mon=$mon_prim
	sh_w9mon=$mon_prim
	sh_w10mon=$mon_prim
	sh_w11mon=$mon_sec
	sh_w12mon=$mon_sec
	sh_w13mon=$mon_prim
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
		sed -i "s/$variable//g" $FINAL_CONFIG
		echo "EMPTY!"
	fi
done

# Add do not change this file
sed -i "1s/^/##################################\n### DO NOT CHANGE THIS FILE!!! ###\n##################################\n\n/" $FINAL_CONFIG

i3-msg restart
