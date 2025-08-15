#!/bin/sh
echo "***** Install Gateway Services Start *****"
sudo chmod 777 ../build/bin/*
sudo chmod 777 ../build/lib/*

sudo cp -rf ../build/lib/*  /usr/local/lib
sudo /sbin/ldconfig
ldconfig -p | grep libiot
./vng.services.access.button.mesh.cloud.mqtt.sh
# ./vng.services.access.button.mesh.local.sh
./vng.services.access.door.mesh.cloud.sh
# ./vng.services.access.door.mesh.local.sh
./vng.services.access.door.mesh.sh
./vng.services.access.reader.mesh.cloud.mqtt.sh
# ./vng.services.access.reader.mesh.local.sh
./vng.services.bluetooth.mesh.serial.access.sh
./vng.services.bluetooth.mesh.serial.sh
./vng.services.device.access.button.status.mesh.sh
./vng.services.device.access.door.status.mesh.sh
./vng.services.device.access.reader.status.mesh.sh
./vng.services.device.gateway.status.sh
./vng.services.device.light.port.levels.mesh.sh
./vng.services.device.light.port.status.mesh.sh
./vng.services.light.hub.group.config.mesh.sh
./vng.services.light.hub.group.mesh.sh
./vng.services.light.hub.mesh.sh
./vng.services.light.hub.scaling.config.mesh.sh
# ./vng.services.synchronizer.button.sh
# ./vng.services.synchronizer.door.sh
# ./vng.services.synchronizer.reader.sh
# ./vng.services.synchronizer.tag.sh
sudo chmod -R 777 /etc/vng/ 
echo "***** Install Gateway Services End *****"
echo "Please don't hesitate to contact HoangNQ3 if this script not work"
