#!/usr/bin/env bash


#### Script de desinstalación para "pass-changer": Programa de cambio rápido de claves para el usuario. ####

# Borra el directorio del programa en /opt/pass-changer, pero sin embargo deja el BackUp de /etc/shadow.bak.
if [[ -e /opt/pass-changer ]]; then
    sudo rm -fr /opt/pass-changer
    echo "El directorio /opt/pass-changer ha sido borrado."
else
    echo "El directorio /opt/pass-changer no existe."
fi

# Localiza y borra el registro de /etc/sudoers.
linea=$(sudo sed -n "/pass-changer/=" /etc/sudoers)

if [[ $linea == "" ]]; then
    echo "No existe el registro en /etc/sudoers."
else
    linea=$(($linea - 2))

    for i in 1 2 3; do
        sudo sed -i "$linea d" /etc/sudoers
    done
fi

if [[ $(sudo tail -1 /etc/sudoers | grep -w PERSONALIZADO) != "" ]]; then
    linea=$(sudo sed -n "/PERSONALIZADO/=" /etc/sudoers)
    linea=$(($linea - 3))
    
    for i in 1 2 3 4; do
        sudo sed -i "$linea d" /etc/sudoers
    done
fi

# Ya solo falta eliminar manualmente los atajos de teclado crados para este programa.
