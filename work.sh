#!/bin/bash

pgrep pidgin 1>/dev/null || i3-msg "exec pidgin" 1>/dev/null
pgrep Mattermost 1>/dev/null || i3-msg "exec mattermost" 1>/dev/null
pgrep thunderbird 1>/dev/null || i3-msg "exec thunderbird" 1>/dev/null
pgrep keepassx2 1>/dev/null | i3-msg "exec keepassx2" 1>/dev/null
pgrep spotify 1>/dev/null || i3-msg "exec spotify" 1>/dev/null
pgrep chromium 1>/dev/null || i3-msg "workspace 1w; exec chromium" 1>/dev/null
