#!/bin/bash

# --- Configuración ---
# Nombre del archivo .service que quieres instalar (debe estar en el mismo directorio)
SOURCE_SERVICE_FILE="ets2server.service"
# --- Fin Configuración ---

TARGET_DIR="/etc/systemd/system"
TARGET_SERVICE_PATH="${TARGET_DIR}/${SOURCE_SERVICE_FILE}"

# 1. Verificar si se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: Este script debe ejecutarse como root (usa sudo)." >&2
  exit 1
fi

# 2. Verificar si el archivo .service de origen existe
if [ ! -f "${SOURCE_SERVICE_FILE}" ]; then
  echo "Error: No se encontró el archivo '${SOURCE_SERVICE_FILE}' en el directorio actual." >&2
  exit 1
fi

# 3. Copiar el archivo al directorio de systemd
echo "Copiando '${SOURCE_SERVICE_FILE}' a '${TARGET_DIR}/'..."
cp "${SOURCE_SERVICE_FILE}" "${TARGET_SERVICE_PATH}"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo. ¿Tienes permisos?" >&2
    exit 1
fi

# 4. Establecer permisos correctos
echo "Estableciendo permisos (644) en '${TARGET_SERVICE_PATH}'..."
chmod 644 "${TARGET_SERVICE_PATH}"
if [ $? -ne 0 ]; then
    echo "Error: No se pudieron establecer los permisos." >&2
    # Podrías intentar eliminar el archivo copiado si falla aquí
    # rm "${TARGET_SERVICE_PATH}"
    exit 1
fi

# 5. Recargar la configuración de systemd
echo "Recargando la configuración de systemd (daemon-reload)..."
systemctl daemon-reload

# 6. Habilitar el servicio para que inicie en el arranque
echo "Habilitando el servicio '${SOURCE_SERVICE_FILE}'..."
systemctl enable "${SOURCE_SERVICE_FILE}"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo habilitar el servicio. ¿El nombre del archivo es correcto y el contenido válido?" >&2
    exit 1
fi

echo ""
echo "¡Éxito!"
echo "El servicio '${SOURCE_SERVICE_FILE}' ha sido instalado y habilitado."
echo "Puedes iniciarlo manualmente ahora con: sudo systemctl start ${SOURCE_SERVICE_FILE}"
echo "Puedes verificar su estado con: sudo systemctl status ${SOURCE_SERVICE_FILE}"
echo "Se iniciará automáticamente la próxima vez que reinicies el sistema."
echo ""
echo "Recuerda: Si tenías una línea '@reboot' o 'monitor' en tu crontab para este servidor, elimínala."

exit 0