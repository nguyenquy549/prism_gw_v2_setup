#!/bin/sh
echo ---- CHANGE STATIC IP ADDRESS ----
echo -n "Current static IP: "
cat /etc/network/interfaces | grep -e "address" | head -1
new_ip=0
cur_ip=0
read -p "ENTER cur ip " cur_ip
read -p "ENTER new ip " new_ip
echo cur_ip : $cur_ip
echo new_ip : $new_ip
sed -i 's/\<'$cur_ip'\>/'$new_ip'/g' /etc/network/interfaces
echo -n "Current SSID: "
cat /etc/hostapd/hostapd.conf | grep -e "ssid"
cur_ssid=0
new_ssid=0
read -p "ENTER cur ssid " cur_ssid
read -p "ENTER new ssid " new_ssid
echo cur_ssid : $cur_ssid
echo new_ssid : $new_ssid
sed -i 's/\<'$cur_ssid'\>/'$new_ssid'/g' /etc/hostapd/hostapd.conf
echo -n "Current psk: "
cat /etc/hostapd/hostapd.conf | grep -e "pass"
cur_psk=0
new_psk=0
read -p "ENTER cur psk " cur_psk
read -p "ENTER new psk " new_psk
echo cur_psk : $cur_psk
echo new_psk : $new_psk
sed -i 's/\<'$cur_psk'\>/'$new_psk'/g' /etc/hostapd/hostapd.conf
echo ---- DONE ETH0 CONFIG ----
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

