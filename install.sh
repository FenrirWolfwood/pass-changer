#!/usr/bin/env bash


#### Script de instalación para "pass-changer": Programa de cambio rápido de claves para el usuario. ####

# Realiza BackUp del fichero de claves /etc/shadow a /etc/shadow.bak por si hay algún problema.
sudo cp /etc/shadow /etc/shadow.bak

# Comprueba que /opt/pass-changer no exista.
if [[ -e /opt/pass-changer ]]; then
    echo "El directorio /opt/pass-changer ya existe. Cancelando la instalación."
    exit
fi

# Copia los ficheros del programa en /opt/pass-changer.
sudo mkdir -p /opt/pass-changer
sudo cp -R . /opt/pass-changer
sudo chmod -R 755 /opt/pass-changer
echo "El directorio /opt/pass-changer se ha copiado correctamente."

# Añade a /etc/sudoers la excepción para que no pida clave de SUDO con este script.
if sudo grep -q "/opt/pass-changer" "/etc/sudoers"; then
    echo "El registro /opt/pass-changer ya existe en /etc/sudoers."
elif sudo grep -q "PERSONALIZADO" "/etc/sudoers"; then
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "# Script para cambiar la clave del usuario con atajos de teclado." | sudo tee -a /etc/sudoers &> /dev/null
    echo "%sudo   ALL=NOPASSWD: /opt/pass-changer/pass-changer.sh" | sudo tee -a /etc/sudoers &> /dev/null
    echo "El registro de /opt/pass-changer se ha añadido en la sección PERSONALIZADO de /etc/sudoers."
else
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "#### PERSONALIZADO ####" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "# Script para cambiar la clave del usuario con atajos de teclado." | sudo tee -a /etc/sudoers &> /dev/null
    echo "%sudo   ALL=NOPASSWD: /opt/pass-changer/pass-changer.sh" | sudo tee -a /etc/sudoers &> /dev/null
    echo "Se ha añadido la sección PERSONALIZADO en /etc/sudoers y se ha añadido en ella el registro de /opt/pass-changer."
fi


# Ya solo falta añadir manualmente los atajos de teclado con el siguiente comando:
#
#   sudo /opt/pass-changer/pass-changer.sh USUARIO NUM-CLAVE
#
# Donde USUARIO es el nombre de tu usuario y NUM-CLAVE es el numero de la clave elegida.
