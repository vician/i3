#!/bin/bash

pgrep chromium 1>/dev/null || i3-msg "workspace 1w; exec chromium" 1>/dev/null
pgrep pidgin 1>/dev/null || i3-msg "exec pidgin" 1>/dev/null
#pgrep Mattermost 1>/dev/null || i3-msg "exec mattermost-desktop" 1>/dev/null
pgrep HipChat 1>/dev/null || i3-msg "exec hipchat4" 1>/dev/null
pgrep thunderbird 1>/dev/null || i3-msg "exec thunderbird" 1>/dev/null
pgrep keepassxc 1>/dev/null | i3-msg "exec keepassxc" 1>/dev/null
pgrep spotify 1>/dev/null || i3-msg "exec spotify" 1>/dev/null
#pgrep telegram 1>/dev/null || i3-msg "exec telegram-desktop" 1>/dev/null
pgrep telegram 1>/dev/null || i3-msg "exec firejail ~/Downloads/Telegram/Telegram" 1>/dev/null
pgrep slack 1>/dev/null || i3-msg "exec slack" 1>/dev/null
