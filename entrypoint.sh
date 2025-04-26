#!/bin/bash

INIT_FILE=".initialized"
TARGET_DIR="/home/ets2server/.local/share/Euro Truck Simulator 2" # Use the volume mount path

mkdir -p "$TARGET_DIR"

if [ ! -f "$INIT_FILE" ]; then
    # Copia los archivos solo la primera vez
    cp /home/ets2server/server_config.sii "$TARGET_DIR/server_config.sii"
    cp /home/ets2server/config_ds.cfg "$TARGET_DIR/config_ds.cfg"
    touch "$INIT_FILE"
    echo "Files copied for the first time."
fi

echo "Initialization complete."

# Keep the container running (replace tail -f /dev/null in docker-compose if needed)
# Add the command to start your actual server here, for example:
# ./ets2server start

# If you want to keep the container running without starting the server immediately,
# use tail -f /dev/null or similar.
tail -f /dev/null