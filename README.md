# pass-changer
Programa de cambio rápido de claves para el usuario.

<br/>

## install.sh
Que hace:
- Realiza BackUp del fichero de claves _/etc/shadow_ a _/etc/shadow.bak_ por si hay algún problema.
- Copia los ficheros del programa en _/opt/pass-changer_.
- Añade a _/etc/sudoers_ la excepción para que no pida clave de SUDO con este script.

Ya solo falta añadir los atajos de teclado con el siguiente comando:

    sudo /opt/pass-changer/pass-changer.sh USUARIO NUM-CLAVE

Donde USUARIO es el nombre de tu usuario y NUM-CLAVE es el numero de la clave elegida.
  
  <br/>

## pass-changer.sh
INSTRUCCIONES: Para llamar a este script es necesario hacerlo como SUDO y pasarle dos parámetros:
- $1 = $USER (para el atajo de teclado escribir directamente el usuario, la variable $USER puede dar problemas)
- $2 = número de clave elegida (parámetro opcional)

Elemplo: `sudo /opt/pass-changer.sh $USER 1`

Al asignarlo a un atajo de teclado, para que no pida contraseña de sudo, es necesario añadir la siguiente línea al fichero /etc/sudoers :

    %sudo    ALL=NOPASSWD: /opt/pass-changer.sh
