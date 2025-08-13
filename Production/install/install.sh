#!/bin/sh
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
echo "***** Install Gateway Services Start *****"
sudo chmod 777 $BASEDIR/../build/bin/*
sudo chmod 777 $BASEDIR/../build/lib/*

sudo cp -rf $BASEDIR/../build/lib/*  /usr/local/lib
sudo /sbin/ldconfig
ldconfig -p | grep libiot
$BASEDIR/vng.services.access.button.mesh.cloud.mqtt.sh
# $BASEDIR/vng.services.access.button.mesh.local.sh
$BASEDIR/vng.services.access.door.mesh.cloud.sh
# $BASEDIR/vng.services.access.door.mesh.local.sh
$BASEDIR/vng.services.access.door.mesh.sh
$BASEDIR/vng.services.access.reader.mesh.cloud.mqtt.sh
# $BASEDIR/vng.services.access.reader.mesh.local.sh
$BASEDIR/vng.services.bluetooth.mesh.serial.access.sh
$BASEDIR/vng.services.bluetooth.mesh.serial.sh
$BASEDIR/vng.services.device.access.button.status.mesh.sh
$BASEDIR/vng.services.device.access.door.status.mesh.sh
$BASEDIR/vng.services.device.access.reader.status.mesh.sh
$BASEDIR/vng.services.device.gateway.status.sh
$BASEDIR/vng.services.device.light.port.levels.mesh.sh
$BASEDIR/vng.services.device.light.port.status.mesh.sh
$BASEDIR/vng.services.light.hub.group.config.mesh.sh
$BASEDIR/vng.services.light.hub.group.mesh.sh
$BASEDIR/vng.services.light.hub.mesh.sh
$BASEDIR/vng.services.light.hub.scaling.config.mesh.sh
# $BASEDIR/vng.services.synchronizer.button.sh
# $BASEDIR/vng.services.synchronizer.door.sh
# $BASEDIR/vng.services.synchronizer.reader.sh
# $BASEDIR/vng.services.synchronizer.tag.sh
sudo chmod -R 777 /etc/vng/
echo "***** Install Gateway Services End *****"
echo "Please don't hesitate to contact HoangNQ3 if this script not work"
