#!/bin/bash

# PUNTO D — Permisos
# Rol: dev

# SERVICIOS — Notación octal

chmod 755 ~/dev/Servicios/Web/
chmod 700 ~/dev/Servicios/Base_de_Datos/
chmod 644 ~/dev/Servicios/Cache/

# MONITOREO — Notación simbólica

chmod u=rwx,g=rx,o=r ~/dev/Monitoreo/Logs/
chmod u=rwx,g=,o= ~/dev/Monitoreo/Alertas/
chmod u=rwx,g=rx,o=rx ~/dev/Monitoreo/Metricas/