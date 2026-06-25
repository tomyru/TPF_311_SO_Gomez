#!/bin/bash
# Con '-e' el script se detiene inmediatamente si algún comando falla
set -e

# =====================================================================
# SECCIÓN 1: CONFIGURACIÓN DE "SERVICIOS" (/dev/sdc1)
echo "[Servicios] Formateando /dev/sdc1 en ext4..."
sudo mkfs.ext4 -F /dev/sdc1

echo "[Servicios] Obteniendo el UUID de /dev/sdc1..."
UUID_SDC1=$(sudo blkid -s UUID -o value /dev/sdc1)

echo "[Servicios] Agregando a /etc/fstab para persistencia..."
echo "UUID=$UUID_SDC1  /home/vagrant/dev/Servicios  ext4  defaults  0  2" | sudo tee -a /etc/fstab

echo "[Servicios] Montando partición y creando estructura inicial..."
sudo mount /home/vagrant/dev/Servicios
sudo mkdir -p /home/vagrant/dev/Servicios/{Base_de_Datos,Cache,Web}


# =====================================================================
# SECCIÓN 2: CONFIGURACIÓN DE "MONITOREO" (/dev/sdc2)
echo "[Monitoreo] Formateando /dev/sdc2 en ext4..."
sudo mkfs.ext4 -F /dev/sdc2

echo "[Monitoreo] Obteniendo el UUID de /dev/sdc2..."
UUID_SDC2=$(sudo blkid -s UUID -o value /dev/sdc2)

echo "[Monitoreo] Agregando a /etc/fstab para persistencia..."
echo "UUID=$UUID_SDC2  /home/vagrant/dev/Monitoreo  ext4  defaults  0  2" | sudo tee -a /etc/fstab

echo "[Monitoreo] Montando partición y creando subcarpetas..."
sudo mount /home/vagrant/dev/Monitoreo
sudo mkdir -p /home/vagrant/dev/Monitoreo/{Alertas,Logs,Metricas}

# =====================================================================
# SECCIÓN 3: CONFIGURACIÓN DE LA PARTICIÓN LÓGICA 1 EN "WEB" (/dev/sdc5)
echo "[Web] Formateando partición lógica /dev/sdc5 en ext4..."
sudo mkfs.ext4 -F /dev/sdc5

echo "[Web] Obteniendo el UUID de /dev/sdc5..."
UUID_SDC5=$(sudo blkid -s UUID -o value /dev/sdc5)

echo "[Web] Agregando a /etc/fstab para persistencia anidada..."
echo "UUID=$UUID_SDC5  /home/vagrant/dev/Servicios/Web  ext4  defaults  0  2" | sudo tee -a /etc/fstab

echo "[Web] Montando la partición lógica dentro de Servicios/Web..."
sudo mount /home/vagrant/dev/Servicios/Web

# =====================================================================
# SECCIÓN 4: AJUSTE FINAL DE PERMISOS GLOBAL
echo "Asignando la propiedad de todas las estructuras al usuario 'vagrant'..."
sudo chown -R vagrant:vagrant /home/vagrant/dev/

echo "PROCESO FINALIZADO"
