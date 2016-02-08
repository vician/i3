#!/bin/bash

systemctl suspend
touch ~/.i3/yubi/force.lock # Do not unlock by smartcard
~/.i3/lock.sh force
