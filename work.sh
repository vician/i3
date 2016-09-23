#!/bin/bash

pgrep pidgin 1>/dev/null || i3-msg "exec pidgin"
pgrep thunderbird 1>/dev/null || i3-msg "exec thunderbird"
pgrep keepassx2 1>/dev/null | i3-msg "exec keepassx2"
pgrep spotify 1>/dev/null || i3-msg "exec spotify" 1>/dev/null
pgrep chromium 1>/dev/null || i3-msg "workspace 1w; exec chromium" 1>/dev/null
