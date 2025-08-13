#!/bin/sh
echo "***** Install Paho MQTT Start *****"
mkdir -p /usr/local/include
sudo install -m 644  build/output/libpaho-mqtt3c.so.1.3 /usr/local/lib
sudo install -m 644  build/output/libpaho-mqtt3cs.so.1.3 /usr/local/lib
sudo install -m 644  build/output/libpaho-mqtt3a.so.1.3 /usr/local/lib
sudo install -m 644  build/output/libpaho-mqtt3as.so.1.3 /usr/local/lib
sudo install  build/output/paho_c_version /usr/local/bin
sudo install  build/output/samples/paho_c_pub /usr/local/bin
sudo install  build/output/samples/paho_c_sub /usr/local/bin
sudo install  build/output/samples/paho_cs_pub /usr/local/bin
sudo install  build/output/samples/paho_cs_sub /usr/local/bin
sudo /sbin/ldconfig /usr/local/lib
ln -s libpaho-mqtt3c.so.1 /usr/local/lib/libpaho-mqtt3c.so
ln -s libpaho-mqtt3cs.so.1 /usr/local/lib/libpaho-mqtt3cs.so
ln -s libpaho-mqtt3a.so.1 /usr/local/lib/libpaho-mqtt3a.so
ln -s libpaho-mqtt3as.so.1 /usr/local/lib/libpaho-mqtt3as.so
sudo install -m 644 src/MQTTAsync.h /usr/local/include
sudo install -m 644 src/MQTTClient.h /usr/local/include
sudo install -m 644 src/MQTTClientPersistence.h /usr/local/include
sudo install -m 644 src/MQTTProperties.h /usr/local/include
sudo install -m 644 src/MQTTReasonCodes.h /usr/local/include
sudo install -m 644 src/MQTTSubscribeOpts.h /usr/local/include
sudo install -m 644 src/MQTTExportDeclarations.h /usr/local/include
sudo install -m 644 doc/man/man1/paho_c_pub.1 /usr/local/share/man/man1
sudo install -m 644 doc/man/man1/paho_c_sub.1 /usr/local/share/man/man1
sudo install -m 644 doc/man/man1/paho_cs_pub.1 /usr/local/share/man/man1
sudo install -m 644 doc/man/man1/paho_cs_sub.1 /usr/local/share/man/man1
sudo ldconfig
echo "***** Install Paho MQTT End *****"