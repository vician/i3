#!/bin/bash

pgrep pidgin 1>/dev/null || pidgin
pgrep thunderbird 1>/dev/null || thunderbird
ps faux | grep keepass2 | grep -v grep 1>/dev/null || keepass2
pgrep spotify 1>/dev/null || i3-msg "workspace =♪; exec spotify" 1>/dev/null
pgrep chromium 1>/dev/null || i3-msg "workspace 1🌎; exec chromium-browser" 1>/dev/null
