#!/bin/sh
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
BIN_DIR=$BASEDIR/../build/bin
FOLDER_SERVICE=device
NAME_SERVICE=access.door.status.mesh

echo "***** vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE Start *****"

INIT_DIR=$BASEDIR/../services/$FOLDER_SERVICE/$FOLDER_SERVICE.$NAME_SERVICE/src/files/etc/init.d/services/$FOLDER_SERVICE/
JSON_DIR=$BASEDIR/../services/$FOLDER_SERVICE/$FOLDER_SERVICE.$NAME_SERVICE/src/files/etc/vng/services/$FOLDER_SERVICE/

sudo cp $BIN_DIR/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE /usr/local/bin
sudo cp $BIN_DIR/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE-* /usr/local/bin
sudo cp $INIT_DIR/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE.service /lib/systemd/system/
sudo cp $INIT_DIR/vng.services.$FOLDER_SERVICE.$NAME_SERVICE /etc/init.d/
sudo chmod 777 /etc/init.d/vng.services.$FOLDER_SERVICE.$NAME_SERVICE
sudo chmod 777 /usr/local/bin/vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE*
sudo mkdir -p /etc/vng/services/$FOLDER_SERVICE/
sudo cp $JSON_DIR/* /etc/vng/services/$FOLDER_SERVICE/

sudo systemctl daemon-reload
sudo systemctl enable  vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE
sudo systemctl start vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE

echo "***** vng.iot.services.$FOLDER_SERVICE.$NAME_SERVICE End *****"