#!/bin/bash

INIT_FILE=".initialized"
TARGET_DIR="/home/atsserver/.local/share/American Truck Simulator"
LOG_DIR="/home/atsserver/log"

if [ -d "$TARGET_DIR" ]; then
    chown -R atsserver:atsserver "$TARGET_DIR"
    chmod -R u+rwX "$TARGET_DIR"
    chown -R atsserver:atsserver "$LOG_DIR"
    chmod -R u+rwX "$LOG_DIR"
fi

service cron start

if [ ! -f "$INIT_FILE" ]; then
    # Create directory as atsserver user
    sudo -u atsserver mkdir -p "$TARGET_DIR"
    # Copy files as atsserver user
    sudo -u atsserver cp /home/atsserver/server_config.sii "$TARGET_DIR/server_config.sii"
    sudo -u atsserver cp /home/atsserver/config_ds.cfg "$TARGET_DIR/config_ds.cfg"
    # Create init file as atsserver user
    sudo -u atsserver touch "$INIT_FILE"
    echo "Files copied for the first time."
fi

echo "Initialization complete."

# Start the server as atsserver user
sudo -u atsserver ./atsserver start

# Keep the container running (this part runs as root, which is fine)
tail -f /dev/null