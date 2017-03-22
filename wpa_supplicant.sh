#!/bin/env bash

pkill wpa_supplicant
pkill wpa_gui
wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
wpa_gui
