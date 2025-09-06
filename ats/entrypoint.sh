#!/bin/bash

TARGET_DIR="/home/atsserver/.local/share/American Truck Simulator"
LOG_DIR="/home/atsserver/log"

if [ -d "$TARGET_DIR" ]; then
    chown -R atsserver:atsserver "$TARGET_DIR"
    chmod -R u+rwX "$TARGET_DIR"
    chown -R atsserver:atsserver "$LOG_DIR"
    chmod -R u+rwX "$LOG_DIR"
fi

service cron start

# Start the server as atsserver user
sudo -u atsserver ./atsserver start

# Keep the container running (this part runs as root, which is fine)
tail -f /dev/null