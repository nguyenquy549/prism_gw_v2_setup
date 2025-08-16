#!/bin/bash
# Add virtual Wi-Fi interface for AP mode (if not already created)

if ! iw dev | grep -q 'wlan0-ap'; then
    echo "[INFO] Creating wlan0-ap interface..."
    iw dev wlan0 interface add wlan0-ap type __ap
    echo "[INFO] Restarting networking.service..."
    sudo systemctl restart networking.service
else
    echo "[INFO] wlan0-ap already exists, skipping."
fi