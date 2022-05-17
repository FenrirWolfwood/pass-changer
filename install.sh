#!/usr/bin/env bash


#### Script de instalación para "pass-changer": Programa de cambio rápido de claves para el usuario. ####

echo -e ""
echo -e "Introduzca su contraseña para autorizar las operaciones."
sudo echo ""

# Comprueba que /opt/pass-changer no exista.
if [[ -e /opt/pass-changer ]]; then
    echo -e " \033[1;31m*\033[0m El directorio /opt/pass-changer ya existe. Cancelando la instalación."
    echo -e ""
    exit
fi

# Realiza BackUp del fichero de claves /etc/shadow a /etc/shadow.bak por si hay algún problema.
echo -e " \033[1;32m*\033[0m Creando copia de /etc/shadow en /etc/shadow.bak como BackUp."
sudo cp /etc/shadow /etc/shadow.bak

# Copia los ficheros del programa en /opt/pass-changer.
sudo mkdir -p /opt/pass-changer
sudo cp -R . /opt/pass-changer
sudo chmod -R 755 /opt/pass-changer/pass-changer.sh /opt/pass-changer/install.sh /opt/pass-changer/uninstall.sh
echo -e " \033[1;32m*\033[0m El directorio /opt/pass-changer se ha copiado correctamente."

# Añade a /etc/sudoers la excepción para que no pida clave de SUDO con este script.
if sudo grep -q "/opt/pass-changer" "/etc/sudoers"; then
    echo -e " \033[1;31m*\033[0m El registro /opt/pass-changer ya existe en /etc/sudoers."
elif sudo grep -q "PERSONALIZADO" "/etc/sudoers"; then
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "# Script para cambiar la clave del usuario con atajos de teclado." | sudo tee -a /etc/sudoers &> /dev/null
    echo "%sudo   ALL=NOPASSWD: /opt/pass-changer/pass-changer.sh" | sudo tee -a /etc/sudoers &> /dev/null
    echo -e " \033[1;32m*\033[0m El registro de /opt/pass-changer se ha añadido a /etc/sudoers en la sección PERSONALIZADO."
else
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "#### PERSONALIZADO ####" | sudo tee -a /etc/sudoers &> /dev/null
    echo "" | sudo tee -a /etc/sudoers &> /dev/null
    echo "# Script para cambiar la clave del usuario con atajos de teclado." | sudo tee -a /etc/sudoers &> /dev/null
    echo "%sudo   ALL=NOPASSWD: /opt/pass-changer/pass-changer.sh" | sudo tee -a /etc/sudoers &> /dev/null
    echo -e " \033[1;32m*\033[0m Se ha añadido la sección PERSONALIZADO en /etc/sudoers y se ha añadido el registro de /opt/pass-changer en ella."
fi

echo -e ""


# Ya solo falta añadir manualmente los atajos de teclado con el siguiente comando:
#
#   sudo /opt/pass-changer/pass-changer.sh USUARIO NUM-CLAVE
#
# Donde USUARIO es el nombre de tu usuario y NUM-CLAVE es el numero de la clave elegida.

