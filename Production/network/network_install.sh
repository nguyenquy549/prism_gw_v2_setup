#!/bin/sh
AP=hostapd
DNS=dnsmasq
WIFI=wpa_supplicant

sudo apt install ifupdown
sudo apt install -y hostapd dnsmasq netfilter-persistent iptables-persistent iptables bridge-utils
sudo cp interfaces /etc/network
sudo cp rc.local /etc
sudo cp dnsmasq.conf /etc
sudo cp wpa_supplicant.conf /etc/wpa_supplicant
sudo cp hostapd.conf /etc/hostapd
sudo cp hostapd /etc/default/hostapd
mkdir -p /usr/local/bin
sudo cp create_wlan0_ap.sh /usr/local/bin
sudo chmod +x /usr/local/bin/create_wlan0_ap.sh
sudo cp create_wlan0_ap.service /etc/systemd/system

echo ---- DONE ETH0 CONFIG ----
sudo systemctl enable networking.service
sudo systemctl start networking.service
echo ---- DAEMON RELOAD ----
sudo systemctl daemon-reload
echo ---- ENABLE WLAN0_AP ----
sudo systemctl enable create_wlan0_ap.service
sudo systemctl start create_wlan0_ap.service
echo ---- ENABLE HOSTAPD SERVICE ----
sudo systemctl unmask hostapd.service
sudo systemctl enable hostapd.service
sudo systemctl restart hostapd.service
echo ---- ENABLE DHCP SERVER SERVICE ----
sudo systemctl unmask dnsmasq.service
sudo systemctl enable dnsmasq.service
sudo systemctl restart dnsmasq.service
echo ---- DISABLE WIFI CONNECT SERVICE ----
sudo systemctl mask wpa_supplicant.service
echo ---- SAVE PERSISTENT CONFIG ----
sudo netfilter-persistent save
echo ---- RESTART NETWORKING ----
sudo systemctl restart networking.service
sleep 5
sudo reboot