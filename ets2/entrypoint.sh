#!/bin/bash

TARGET_DIR="/home/ets2server/.local/share/Euro Truck Simulator 2"
LOG_DIR="/home/ets2server/log"

if [ -d "$TARGET_DIR" ]; then
    chown -R ets2server:ets2server "$TARGET_DIR"
    chmod -R u+rwX "$TARGET_DIR"
    chown -R ets2server:ets2server "$LOG_DIR"
    chmod -R u+rwX "$LOG_DIR"
fi

service cron start

# Start the server as ets2server user
sudo -u ets2server ./ets2server start

# Keep the container running (this part runs as root, which is fine)
tail -f /dev/null