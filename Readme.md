# ☼ Script de Bash para Crear Archivos y Directorios Recursivamente ☼
## Este script de Bash te permite crear archivos o directorios de forma recursiva. Proporciona las siguientes características:

### Creación de archivos y directorios con nombres personalizados.
- Opción para editar los archivos después de crearlos.
- Programación para crear archivos con un intervalo de tiempo entre ellos.
- Posibilidad de escribir una dirección de correo electrónico para recibir notificaciones.

### Uso
Para ejecutar el script, simplemente haz lo siguiente:

./Recur.sh

- El script te guiará a través de las opciones disponibles y te permitirá realizar las operaciones deseadas.

### Características

- Crear Archivos y Directorios: Puedes especificar la ruta, el nombre base, el número inicial y la cantidad de archivos o directorios a crear.

- Editar Archivos: Después de crear los archivos, tienes la opción de editarlos.

- Programar Creación de Archivos: Puedes programar la creación de archivos con un intervalo de tiempo entre cada uno.

- Notificación por Correo Electrónico: Cuando los archivos o directorios se crean con éxito, se envía un correo electrónico a la dirección especificada para notificarlo.

### Requisitos
- dialog: Se utiliza para la interfaz de usuario en el terminal.
- mail: Se utiliza para enviar correos electrónicos desde el terminal.
- Configuración de mail
- Antes de utilizar la función de notificación por correo electrónico, asegúrate de que mail esté correctamente configurado en tu sistema para enviar correos electrónicos.

sudo apt-get install postfix
- Sigue las instrucciones de configuración de postfix durante la instalación.

### Notas
- Asegúrate de tener permisos suficientes para crear archivos o directorios en las rutas especificadas.

- Antes de programar la creación de archivos con un intervalo de tiempo, considera los posibles efectos en el rendimiento y los recursos del sistema.

Este script proporciona una forma sencilla de crear archivos y directorios de forma recursiva, con opciones adicionales para facilitar la administración y la notificación por correo electrónico.# -Recur-
