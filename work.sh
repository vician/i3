#!/bin/bash

pgrep chromium 1>/dev/null || i3-msg "workspace 1w; exec chromium" 1>/dev/null
pgrep pidgin 1>/dev/null || i3-msg "exec pidgin" 1>/dev/null
pgrep thunderbird 1>/dev/null || i3-msg "exec thunderbird" 1>/dev/null
pgrep keepassxc 1>/dev/null | i3-msg "exec keepassxc" 1>/dev/null
pgrep spotify 1>/dev/null || i3-msg "exec spotify" 1>/dev/null
pgrep Telegram 1>/dev/null || i3-msg "exec telegram" 1>/dev/null
pgrep rambox 1>/dev/null || i3-msg "exec rambox" 1>/dev/null
pgrep standardnotes 1>/dev/null || i3-msg "exec standardnotes-desktop" 1>/dev/null
