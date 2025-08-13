#!/bin/sh

echo "***** Setup Serial Config  Start *****" 
BASEDIR=$(dirname "$SCRIPT")

sudo cp $BASEDIR/config.txt  /boot/firmware/

echo "***** Setup Serial Config  End *****"
