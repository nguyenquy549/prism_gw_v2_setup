#!/bin/bash
# Add virtual Wi-Fi interface
if ! iw dev | grep -q 'wlan0-ap'; then
    iw dev wlan0 interface add wlan0-ap type __ap
fi
sudo systemctl restart networking.service
