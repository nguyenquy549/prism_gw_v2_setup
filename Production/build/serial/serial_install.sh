#!/bin/sh

echo "***** Setup Serial Config  Start *****" 
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

sudo cp $BASEDIR/config.txt  /boot/firmware/

echo "***** Setup Serial Config  End *****"
