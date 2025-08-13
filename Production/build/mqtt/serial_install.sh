#!/bin/sh

echo "***** Setup Serial Config  Start *****" 
BASEDIR=$(dirname "$SCRIPT")
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto.service
sudo cp $BASEDIR/mosquitto.conf  /boot/firmware/
sudo systemctl restart mosquitto
sudo systemctl status mosquitto
echo "***** Setup Serial Config  End *****"
