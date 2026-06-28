#!/bin/bash
set -e

echo "Creando grupos..."
sudo groupadd g_sysadmin
sudo groupadd g_infra

echo "Creando usuario u_sysadmin..."
PASS_SYSADMIN=$(openssl passwd -6 "u_sysadmin")
sudo useradd -m -g g_sysadmin -G g_infra -p "$PASS_SYSADMIN" -s /bin/bash u_sysadmin

echo "PROCESO FINALIZADO"