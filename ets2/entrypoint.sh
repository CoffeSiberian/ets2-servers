#!/bin/bash

INIT_FILE=".initialized"
TARGET_DIR="/home/ets2server/.local/share/Euro Truck Simulator 2"
LOG_DIR="/home/ets2server/log"

if [ -d "$TARGET_DIR" ]; then
    chown -R ets2server:ets2server "$TARGET_DIR"
    chmod -R u+rwX "$TARGET_DIR"
    chown -R ets2server:ets2server "$LOG_DIR"
    chmod -R u+rwX "$LOG_DIR"
fi

service cron start

if [ ! -f "$INIT_FILE" ]; then
    # Create directory as ets2server user
    sudo -u ets2server mkdir -p "$TARGET_DIR"
    # Copy files as ets2server user
    sudo -u ets2server cp /home/ets2server/server_config.sii "$TARGET_DIR/server_config.sii"
    sudo -u ets2server cp /home/ets2server/config_ds.cfg "$TARGET_DIR/config_ds.cfg"
    # Create init file as ets2server user
    sudo -u ets2server touch "$INIT_FILE"
    echo "Files copied for the first time."
fi

echo "Initialization complete."

# Start the server as ets2server user
sudo -u ets2server ./ets2server start

# Keep the container running (this part runs as root, which is fine)
tail -f /dev/null