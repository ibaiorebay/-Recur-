# <span style="color:blue">☼ RECUR ☼</span>
## Este script de Bash te permite crear archivos o directorios de forma recursiva. Proporciona las siguientes características:

### Creación de archivos y directorios con nombres personalizados.
- Opción para editar los archivos después de crearlos.
- Posibilidad de escribir una dirección de correo electrónico para recibir notificaciones.

### Uso
Antes que nada, descomprime todos los archivos a una carpeta (tienen que estar los dos archivos en ella)
Luego hay que añadir esa carpeta a PATH:
- export PATH=&PATH:(Direccion absoluta de la carpeta en la que has guardado los scripts)

Luego hay que instalar ssmtp:

- sudo apt install ssmtp

Y abrir el archivo de configuración en /etc/ssmtp/ssmtp.comf:

- sudo nano /etc/ssmtp/ssmtp.comf (reemplaza nano con tu editor de texto de confianza)

Y configurarlo de esta manera: 

- root=(tu direccion de correo electronico)
- mailhub=smtp.gmail.com:587
- rewriteDomain=gmail.com
- hostname=(el nombre de tu equipo)
- TLS_CS_FILE=/etc/ssl/certs/ca-certificates.crt
- UseTLS=Yes
- UseSTARTTLS=Yes
- AuthUser=noreplyrecur@gmail.com
- AuthPass=qbzoetxseqdzpjyy

Para ejecutar el script, simplemente haz lo siguiente:

Recur.sh

- El script te guiará a través de las opciones disponibles y te permitirá realizar las operaciones deseadas.

### Características

- Crear Archivos y Directorios: Puedes especificar la ruta, el nombre base, el número inicial y la cantidad de archivos o directorios a crear.

- Editar Archivos: Después de crear los archivos, tienes la opción de editarlos.

- Notificación por Correo Electrónico: Cuando los archivos o directorios se crean con éxito, se envía un correo electrónico a la dirección especificada para notificarlo.

sudo apt-get install ssmtp

### Requisitos
- dialog: Se utiliza para la interfaz de usuario en el terminal.
- mail: Se utiliza para enviar correos electrónicos desde el terminal.
- Configuración de mail
- Antes de utilizar la función de notificación por correo electrónico, asegúrate de que mail esté correctamente configurado en tu sistema para enviar correos electrónicos.

### Notas
- Asegúrate de tener permisos suficientes para crear archivos o directorios en las rutas especificadas.

- Antes de programar la creación de archivos con un intervalo de tiempo, considera los posibles efectos en el rendimiento y los recursos del sistema.

Este script proporciona una forma sencilla de crear archivos y directorios de forma recursiva, con opciones adicionales para facilitar la administración y la notificación por correo electrónico.# -Recur-
