#!/usr/bin/env bash


#### Script de desinstalación para "pass-changer": Programa de cambio rápido de claves para el usuario. ####

echo -e ""
echo -e "Introduzca su contraseña para autorizar las operaciones."
sudo echo ""

# Comprueba si existe el BacUp de claves en /etc/shadow.bak y si no está lo crea de nuevo.
if [[ -e /etc/shadow.bak ]]; then
    echo -e " \033[1;32m*\033[0m Por precaución se conserva el BackUp de claves en /etc/shadow.bak creado durante la instalación."
else
    echo -e " \033[1;33m*\033[0m No se ha encontrado en /etc/shadow.bak ningún BackUp de claves. Se creará uno nuevo por precaución."
    sudo cp /etc/shadow /etc/shadow.bak
fi

# Borra el directorio del programa en /opt/pass-changer, pero sin embargo deja el BackUp de /etc/shadow.bak.
if [[ -e /opt/pass-changer ]]; then
    sudo rm -fr /opt/pass-changer
    echo -e " \033[1;32m*\033[0m El directorio /opt/pass-changer ha sido borrado."
else
    echo -e " \033[1;31m*\033[0m El directorio /opt/pass-changer no existe y no ha podido ser borrado."
fi

# Localiza y borra el registro de /etc/sudoers.
linea=$(sudo sed -n "/pass-changer/=" /etc/sudoers)

if [[ $linea == "" ]]; then
    echo -e " \033[1;31m*\033[0m No se ha encontrado el registro en /etc/sudoers para poder borrarlo."
else
    linea=$(($linea - 2))

    for i in 1 2 3; do
        sudo sed -i "$linea d" /etc/sudoers
    done

    echo -e " \033[1;32m*\033[0m El registro en /etc/sudoers ha sido borrado."
fi

if [[ $(sudo tail -1 /etc/sudoers | grep -w PERSONALIZADO) != "" ]]; then
    linea=$(sudo sed -n "/PERSONALIZADO/=" /etc/sudoers)
    linea=$(($linea - 3))
    
    for i in 1 2 3 4; do
        sudo sed -i "$linea d" /etc/sudoers
    done

    echo -e " \033[1;32m*\033[0m La sección PERSONALIZADO ha quedado vacía y también ha sido borrada."
fi

echo -e ""


# Ya solo falta eliminar manualmente los atajos de teclado crados para este programa.

