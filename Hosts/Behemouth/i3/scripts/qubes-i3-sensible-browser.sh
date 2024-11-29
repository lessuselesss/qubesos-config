#!/bin/bash

# By @andyleitermann
# Mine lives in /usr/local/bin/qubes-i3-sensible-browser.sh
# (as referenced in my i3/config - triggered by $mod+Shift+Return)
# This file is referenced in i3/config, triggered by $mod+Shift+Return
# Should open the focused qube's default browser
# Unless it's dom0, or if the qube can't be determined,
# then open Tor Browser in Whonix dvm

# Get focused window's Qube name
FOCUSED_QUBE=$(xprop -id $(xdotool getwindowfocus) | grep "_QUBES_VMNAME" | awk -F '"' '{print $2}' | head -n 1)

echo "Focused QUBE: $FOCUSED_QUBE" >> /tmp/qubes-browser-debug.log

if [ -z "$FOCUSED_QUBE" ]; then
	# Fallback If no qube is detected, assume it's whonix Tor browser
	qvm-run anon-whonix '/usr/bin/torbrowser'
else
	# Otherwise, open the default browser in the current focused Qube
	qvm-run "$FOCUSED_QUBE" 'xdg-open https://news.ycombinator.com'
fi
