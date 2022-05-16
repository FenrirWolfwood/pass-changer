#!/usr/bin/env bash


#### Script de desinstalación para "pass-changer": Programa de cambio rápido de claves para el usuario. ####

# Borra la el directorio del programa en /opt/pass-changer, pero sin embargo deja el BackUp de /etc/shadow.bak.
sudo rm -fr /opt/pass-changer

# Localiza y borra el registro de /etc/sudoers.
linea=$(sudo sed -n "/pass-changer/=" /etc/sudoers)
linea=$(($linea - 2))

for i in 1 2 3; do
    sudo sed -i "$linea d" /etc/sudoers
done

# Ya solo queda eliminar manualmente los atajos de teclado crados para este programa.
