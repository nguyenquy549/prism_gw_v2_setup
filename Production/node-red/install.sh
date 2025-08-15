#!/bin/bash
set -e  # Dừng script nếu có lỗi

echo "***** Install Node-RED Start *****"

# Lấy thư mục chứa script
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

# Cài Nginx nếu chưa có
if ! command -v nginx &>/dev/null; then
    echo "[INFO] Installing Nginx..."
    sudo apt update
    sudo apt install -y nginx
fi

# Cài Node-RED (Node.js LTS + Node-RED service)
echo "[INFO] Installing Node-RED..."
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

# Xác định user để copy settings.js (ưu tiên 'admin', nếu không thì dùng user đang chạy script)
TARGET_USER="admin"
if ! id "$TARGET_USER" &>/dev/null; then
    TARGET_USER=$(whoami)
    echo "[WARN] User 'admin' không tồn tại, dùng user '$TARGET_USER' thay thế."
fi

TARGET_DIR="/home/$TARGET_USER/.node-red"
mkdir -p "$TARGET_DIR"

# Copy file cấu hình Node-RED
if [ -f "$BASEDIR/settings.js" ]; then
    sudo cp "$BASEDIR/settings.js" "$TARGET_DIR/"
    sudo chown "$TARGET_USER":"$TARGET_USER" "$TARGET_DIR/settings.js"
else
    echo "[WARN] settings.js không tồn tại, bỏ qua bước copy."
fi

# Bật và khởi động Node-RED service
sudo systemctl enable nodered.service
sudo systemctl start nodered.service

# Cấu hình Nginx reverse proxy
if [ -f "$BASEDIR/nodered" ]; then
    sudo cp "$BASEDIR/nodered" /etc/nginx/sites-available/
    sudo ln -sf /etc/nginx/sites-available/nodered /etc/nginx/sites-enabled/
    sudo rm -f /etc/nginx/sites-enabled/default
    sudo nginx -t
    sudo systemctl reload nginx
else
    echo "[WARN] File cấu hình Nginx 'nodered' không tồn tại, bỏ qua."
fi

echo "***** Install Node-RED End *****"
