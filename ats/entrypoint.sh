#!/bin/bash

INIT_FILE=".initialized"
TARGET_DIR="/home/atsserver/.local/share/American Truck Simulator"

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
# Ensure the atsserver binary is executable by the atsserver user and located correctly
# If atsserver is not in PATH for atsserver user, specify the full path
# Example: sudo -u atsserver /path/to/atsserver start
sudo -u atsserver ./atsserver start

# Keep the container running (this part runs as root, which is fine)
tail -f /dev/null