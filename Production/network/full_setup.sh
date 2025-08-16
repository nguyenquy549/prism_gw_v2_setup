✅ CÁCH THỰC HIỆN
🔧 BƯỚC 1: Tạo bridge br0 chứa eth1 và wlan0-ap
File /etc/network/interfaces:

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp  # hoặc static nếu cần

auto br0
iface br0 inet static
    address 192.168.21.1
    netmask 255.255.255.0
    bridge_ports eth1 wlan0-ap
    bridge_stp off
    bridge_fd 0
    bridge_maxwait 0
eth0 là đầu vào Internet (WAN), br0 là LAN (dùng làm gateway).

🔁 BƯỚC 2: Bật IP forwarding

sudo sysctl -w net.ipv4.ip_forward=1
Để cấu hình luôn bật khi khởi động:


sudo nano /etc/sysctl.conf
Thêm dòng (hoặc bỏ comment):


net.ipv4.ip_forward=1
🔥 BƯỚC 3: Thiết lập NAT (masquerade) để br0 có thể truy cập internet qua eth0

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
Lưu iptables vĩnh viễn:


sudo netfilter-persistent save
📶 BƯỚC 4: Dnsmasq cấu hình DHCP cho br0
Trong file dnsmasq.conf bạn đã có cấu hình phù hợp:


interface=br0
dhcp-range=192.168.21.100,192.168.21.200,12h
dhcp-option=3,192.168.21.1
dhcp-option=6,8.8.8.8,8.8.4.4
⚙️ BƯỚC 5: Hostapd phát Wi-Fi từ wlan0-ap
File hostapd.conf của bạn đã đúng:


interface=wlan0-ap
ssid=RPI_GW02
wpa_passphrase=Mitek2024!
...
✅ TỔNG KẾT MẠNG
Interface	Vai trò	IP
eth0	WAN (Internet in)	DHCP hoặc Static
br0	LAN (eth1 + wlan0-ap)	192.168.21.1
eth1	LAN thành phần bridge	N/A
wlan0-ap	Wi-Fi Access Point	N/A

🚀 KHỞI ĐỘNG LẠI MẠNG

sudo systemctl restart networking
sudo systemctl restart dnsmasq
sudo systemctl restart hostapd
Bạn có thể dùng script create_wlan0_ap.sh và apply_network.sh như hiện tại, chỉ cần đảm bảo /etc/network/interfaces đúng theo trên.

Nếu bạn cần mình chỉnh lại toàn bộ file interfaces hoặc tạo script tự động hóa việc này, chỉ cần nói rõ IP bạn muốn gán cho br0 và mình sẽ hỗ trợ.




🧰 Step 1: Install Nginx (if not yet)

sudo apt update
sudo apt install nginx -y
⚙️ Step 2: Create Nginx config for Node-RED
Create a new config file:

sudo nano /etc/nginx/sites-available/nodered
Paste this content:

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:1880;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
🔗 Step 3: Enable the config
Link it to sites-enabled:

sudo ln -s /etc/nginx/sites-available/nodered /etc/nginx/sites-enabled/
Remove the default config (optional but recommended):


sudo rm /etc/nginx/sites-enabled/default
✅ Step 4: Test and reload Nginx

sudo nginx -t
sudo systemctl reload nginx
📥 Step 5: Access Node-RED via port 80
Now you can open:

http://<raspberry-pi-ip>/



🔹 1. Tạm thời stop service tạo AP
sudo systemctl stop create_wlan0_ap.service
Service create_wlan0_ap.service của bạn chỉ chạy kiểu oneshot → nó không giữ tiến trình sống.

Nhưng interface wlan0-ap vẫn còn tồn tại sau khi stop.

🔹 2. Xoá interface wlan0-ap (tắt AP ngay)
sudo iw dev wlan0-ap del


→ Interface ảo biến mất, không phát Wi-Fi nữa.

🔹 3. Tắt luôn service để lần boot sau không tạo lại
sudo systemctl disable create_wlan0_ap.service

🔹 4. Nếu muốn bật lại

Enable service:

sudo systemctl enable create_wlan0_ap.service
sudo systemctl start create_wlan0_ap.service


Hoặc tạo lại interface bằng tay:

sudo iw dev wlan0 interface add wlan0-ap type __ap