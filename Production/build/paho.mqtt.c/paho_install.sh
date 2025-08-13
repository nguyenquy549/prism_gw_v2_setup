#!/bin/sh
echo "***** Install Paho MQTT Start *****"
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
mkdir -p /usr/local/include
sudo install -m 644  $BASEDIR/build/output/libpaho-mqtt3c.so.1.3 /usr/local/lib
sudo install -m 644  $BASEDIR/build/output/libpaho-mqtt3cs.so.1.3 /usr/local/lib
sudo install -m 644  $BASEDIR/build/output/libpaho-mqtt3a.so.1.3 /usr/local/lib
sudo install -m 644  $BASEDIR/build/output/libpaho-mqtt3as.so.1.3 /usr/local/lib
sudo install  $BASEDIR/build/output/paho_c_version /usr/local/bin
sudo install  $BASEDIR/build/output/samples/paho_c_pub /usr/local/bin
sudo install  $BASEDIR/build/output/samples/paho_c_sub /usr/local/bin
sudo install  $BASEDIR/build/output/samples/paho_cs_pub /usr/local/bin
sudo install  $BASEDIR/build/output/samples/paho_cs_sub /usr/local/bin
sudo /sbin/ldconfig /usr/local/lib
sudo ln -s libpaho-mqtt3c.so.1 /usr/local/lib/libpaho-mqtt3c.so
sudo ln -s libpaho-mqtt3cs.so.1 /usr/local/lib/libpaho-mqtt3cs.so
sudo ln -s libpaho-mqtt3a.so.1 /usr/local/lib/libpaho-mqtt3a.so
sudo ln -s libpaho-mqtt3as.so.1 /usr/local/lib/libpaho-mqtt3as.so
sudo install -m 644 $BASEDIR/src/MQTTAsync.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTClient.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTClientPersistence.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTProperties.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTReasonCodes.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTSubscribeOpts.h /usr/local/include
sudo install -m 644 $BASEDIR/src/MQTTExportDeclarations.h /usr/local/include
sudo install -m 644 $BASEDIR/doc/man/man1/paho_c_pub.1 /usr/local/share/man/man1
sudo install -m 644 $BASEDIR/doc/man/man1/paho_c_sub.1 /usr/local/share/man/man1
sudo install -m 644 $BASEDIR/doc/man/man1/paho_cs_pub.1 /usr/local/share/man/man1
sudo install -m 644 $BASEDIR/doc/man/man1/paho_cs_sub.1 /usr/local/share/man/man1
sudo ldconfig
echo "***** Install Paho MQTT End *****"