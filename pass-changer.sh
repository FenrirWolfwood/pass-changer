#!/usr/bin/env bash


# INSTRUCCIONES: Para llamar a este script es necesario hacerlo como SUDO y pasarle dos parámetros:
#
# 	$1 = $USER (para el atajo de teclado escribir directamente el usuario, la variable $USER puede dar problemas)
# 	$2 = número de clave elegida (parámetro opcional)
#
# Elemplo: sudo /opt/pass-changer.sh $USER 1
#
# Al asignarlo a un atajo de teclado, para que no pida contraseña de sudo, es necesario añadir la siguiente línea al fichero /etc/sudoers :
#
#	%sudo	ALL=NOPASSWD: /opt/pass-changer.sh



# Guarda las variables pasadas al script.
usuario=$1
clave=$2

# Verifica que el usuario pasado al script existe.
if [[ $(sudo cat /etc/shadow | grep ^$usuario:) == "" ]]; then
	echo -e "El usuario \"$usuario\" no existe."
fi

# Selección de la clave.
case $clave in
	1) echo -e "Clave 1\nClave 1" | passwd $usuario ;;
	2) echo -e "Clave 2\nClave 2" | passwd $usuario ;;
	3) echo -e "Clave 3\nClave 3" | passwd $usuario ;;
	4) echo -e "Clave 4\nClave 4" | passwd $usuario ;;
	5) echo -e "Clave 5\nClave 5" | passwd $usuario ;;
	6) echo -e "Clave 6\nClave 6" | passwd $usuario ;;
	*) echo -e "Clave defecto\nClave defecto" | passwd $usuario ;;
esac
