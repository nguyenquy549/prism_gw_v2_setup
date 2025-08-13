#!/bin/sh
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
sudo chmod -R 777 $BASEDIR/Production
echo "***** Install Gateway V2 End *****"
sudo apt-get update
sudo apt-get install build-essential git libssl-dev
sudo apt install libjson-c-dev
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libsqlite3-dev
sudo apt install build-essential libpython3-dev libdbus-1-dev
$BASEDIR/build/mqtt/serial_install.sh
$BASEDIR/build/paho.mqtt.c/paho_install.sh
$BASEDIR/build/serial/serial_install.sh
$BASEDIR/install/install.sh
sudo reboot
