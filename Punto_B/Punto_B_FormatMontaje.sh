#!/bin/bash
set -e
# CONFIGURACIÓN DE "SERVICIOS" (/dev/sdc1)
echo "Formateando /dev/sdc1 en ext4..."
sudo mkfs.ext4 -F /dev/sdc1
echo "Obteniendo el UUID de /dev/sdc1..."
UUID_SDC1=$(sudo blkid -s UUID -o value /dev/sdc1)
echo "Agregando /dev/sdc1 al archivo /etc/fstab para hacerlo persistente..."
echo "UUID=$UUID_SDC1  /home/vagrant/dev/Servicios  ext4  defaults  0  2" | sudo tee -a /etc/fstab
echo "Montando la partición y creando las subcarpetas de Servicios..."
sudo mount /home/vagrant/dev/Servicios
sudo mkdir -p /home/vagrant/dev/Servicios/{Base_de_Datos,Cache,Web}
# AJUSTE FINAL DE PERMISOS
echo "Asignando la propiedad de las carpetas al usuario 'vagrant'..."
sudo chown -R vagrant:vagrant /home/vagrant/dev/Servicios
