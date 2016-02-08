#!/bin/bash

# Return 0 if locked by approved card
# 1 if not

last=$(timeout 1 pcsc_scan -n)
echo $last | grep "$(cat ~/.i3/yubi/approved.txt)"
exited=$?
echo "exited: $exited"
exit $exited
