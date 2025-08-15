#!/bin/bash
echo "***** Install Node-RED Start *****"
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo cp $BASEDIR/settings.js /home/admin/.node-red/
sudo systemctl enable nodered.service
sudo systemctl start nodered.service

sudo cp $BASEDIR/nodered /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/nodered /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
echo "***** Install Node-RED End *****"