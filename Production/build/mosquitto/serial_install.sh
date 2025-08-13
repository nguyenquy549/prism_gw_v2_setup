#!/bin/sh

echo "***** Setup mosquitto Config  Start *****" 
BASEDIR=$(dirname "$SCRIPT")
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto.service
mosquitto -v
sudo cp $BASEDIR/mosquitto.conf  /boot/firmware/
sudo systemctl restart mosquitto
sudo systemctl status mosquitto
echo "***** Setup mosquitto Config  End *****"
