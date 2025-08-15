#!/bin/sh
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
FOLDER_SERVICE=device
NAME_SERVICE=access.reader.status.mesh

echo "***** vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE Start *****"

sudo systemctl stop vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE.service
sudo systemctl disable vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE.service


INIT_DIR=$BASEDIR/../services/$FOLDER_SERVICE/$FOLDER_SERVICE.$NAME_SERVICE/src/files/etc/init.d/services/$FOLDER_SERVICE/
JSON_DIR=$BASEDIR/../services/$FOLDER_SERVICE/$FOLDER_SERVICE.$NAME_SERVICE/src/files/etc/vng/services/$FOLDER_SERVICE/

sudo rm -f /usr/local/bin/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE
sudo rm -f /usr/local/bin/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE-*
sudo rm -f /lib/systemd/system/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE.service
sudo rm -f /etc/init.d/vng.services.$FOLDER_SERVICE.$NAME_SERVICE
sudo rm -f /etc/vng/services/$FOLDER_SERVICE/$NAME_SERVICE.json

sudo systemctl daemon-reload

echo "***** vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE End *****"