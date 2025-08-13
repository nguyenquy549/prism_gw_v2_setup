#!/bin/sh
setup_ssh_key() 
{
    local hostname="$1"
    local ip="$2"

    # Remove old key from known_hosts
    # ssh-keygen -f "/home/hoang/.ssh/known_hosts" -R "${ip}"

    # Generate an SSH key if it doesn't already exist
    # if [ ! -f ~/.ssh/id_rsa ]; then
    #     ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
    # fi

    # Copy the SSH key to the target machine
    ssh-copy-id ${hostname}@${ip} || {
        echo "Failed to copy SSH key to ${ip}"
        exit 1
    }

    echo "SSH key successfully copied to ${hostname}@${ip}"
}
ip=""
hostname=""
read -p "ENTER host_name " hostname
read -p "ENTER IP " ip
echo ip : $ip
echo hostname : $hostname
AP=hostapd
DNS=dnsmasq
WIFI=wpa_supplicant

######### KEY GEN #############
echo ---- KEY GEN PASSWORD SSH ----
setup_ssh_key $hostname $ip

echo ---- CREATE ROOT PASSWORD ----
ssh ${hostname}@${ip} "sudo sh -c 'echo root:1 | chpasswd'"

echo ---- DOWNLOAD DEPENDENCIES ----
ssh ${hostname}@${ip} "sudo apt-get update"
ssh ${hostname}@${ip} "sudo apt install -y hostapd dnsmasq netfilter-persistent iptables-persistent iptables bridge-utils "
echo ---- DONE DOWNLOAD ----

echo ---- ALLOW ROOT SSH ----
ssh ${hostname}@${ip} "sudo sed -i 's/\#PermitRootLogin prohibit-password\>/PermitRootLogin yes/g' /etc/ssh/sshd_config"
ssh ${hostname}@${ip} "sudo service ssh restart"
hostname=root
setup_ssh_key $hostname $ip

#######################################
#prompt change static ip  (cat-->input)
echo ---- STARTING COPY FILE ----
scp interfaces ${hostname}@${ip}:/etc/network
scp rc.local ${hostname}@${ip}:/etc
scp ${DNS}.conf ${hostname}@${ip}:/etc
scp ${WIFI}.conf ${hostname}@${ip}:/etc/${WIFI}
scp ${AP}.conf ${hostname}@${ip}:/etc/${AP}
scp ${AP} ${hostname}@${ip}:/etc/default/${AP}
ssh ${hostname}@${ip} " mkdir -p /usr/local/bin"
scp create_wlan0_ap.sh ${hostname}@${ip}:/usr/local/bin
ssh ${hostname}@${ip} "sudo chmod +x /usr/local/bin/create_wlan0_ap.sh"
scp create_wlan0_ap.service ${hostname}@${ip}:/etc/systemd/system
scp apply_network.sh ${hostname}@${ip}:~
echo ---- DONE FILE TRANSFER ----
ssh -t ${hostname}@${ip} "sudo ~/./apply_network.sh"
