#!/bin/sh

echo "***** Setup Serial Config  Start *****" 
BASEDIR=$(dirname "$SCRIPT")

// copy and reply
sudo cp -rf $BASEDIR/config.txt  /boot/firmware/

echo "***** Setup Serial Config  End *****"
