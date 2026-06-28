#!/bin/bash
set -e

echo "Creando grupos..."
sudo groupadd g_manager
sudo groupadd g_infra

echo "Creando usuario u_manager..."
PASS_MANAGER=$(openssl passwd -6 "u_manager")
sudo useradd -m -g g_manager -G g_infra -p "$PASS_MANAGER" -s /bin/bash u_manager

echo "PROCESO FINALIZADO"