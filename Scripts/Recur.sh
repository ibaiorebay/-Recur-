#!/bin/bash
email=""
mandar_correo(){
	./enviar_correo "$email"
}
mostrar_menu_principal() {
	dialog --clear --backtitle "Menú Principal" \
	--title "Seleccione una opción" \
	--menu "Use las flechas para moverse y ENTER para seleccionar:" 15 50 5 \
	1 "Crear ficheros" \
	2 "Crear directorios" \
	3 "Editar ficheros" \
	4 "Definir dirección de correo" \
	5 "Salir" \
	2> salida
}
   
crear_ficheros() {
    ruta=$(dialog --inputbox "Introduce la ruta donde quieres crear los ficheros:" 8 60 2>&1 >/dev/tty)
    if [ -z "$ruta" ]; then
   	 dialog --msgbox "Error: La ruta no puede estar vacía." 8 40
   	 return
    fi

    if [ ! -d "$ruta" ]; then
   	 dialog --msgbox "Error: La ruta especificada no existe." 8 40
   	 return
    fi

    nombre=$(dialog --inputbox "Introduce el nombre base para los ficheros:" 8 60 2>&1 >/dev/tty)
    if [ -z "$nombre" ]; then
   	 dialog --msgbox "Error: El nombre base no puede estar vacío." 8 40
   	 return
    fi

    numero=$(dialog --inputbox "Introduce el número inicial para los ficheros:" 8 60 2>&1 >/dev/tty)
    if [ -z "$numero" ]; then
   	 dialog --msgbox "Error: El número inicial no puede estar vacío." 8 40
   	 return
    fi

    cantidad=$(dialog --inputbox "Introduce la cantidad de ficheros a crear:" 8 60 2>&1 >/dev/tty)
    if [ -z "$cantidad" ]; then
   	 dialog --msgbox "Error: La cantidad no puede estar vacía." 8 40
   	 return
    fi

    if [ ! -d "$ruta" ]; then
   	 mkdir -p "$ruta" || { dialog --msgbox "Error: No se pudo crear el directorio especificado." 8 40; return; }
    fi

    (
   	 for (( i = 1; i <= cantidad; i++ )); do
   		 touch "${ruta}/${nombre}${numero}.txt" || { dialog --msgbox "Error: No se pudo crear el fichero." 8 40; return; }
   		 echo "$((i * 100 / cantidad))"
   		 ((numero++))
   		 sleep 0.1
   	 done
   	 echo "100"
    ) | dialog --gauge "Creando ficheros en $ruta..." 8 70 0
	mandar_correo
    if dialog --yesno "¿Deseas editar alguno de los ficheros recién creados?" 8 60; then
   	 editar_ficheros "$ruta" "$nombre"
    fi
}

editar_ficheros() {
    ruta="$1"
    nombre="$2"

    lista_ficheros=()
    while IFS= read -r -d '' fichero; do
   	 lista_ficheros+=("$(basename "$fichero")")
    done < <(find "$ruta" -name "${nombre}*.txt" -print0)

    seleccion=$(dialog --backtitle "Editar Ficheros" \
   	 --title "Selecciona un fichero para editar" \
   	 --menu "Use las flechas para moverse y ENTER para seleccionar:" 15 60 10 \
   	 "${lista_ficheros[@]}" \
   	 2>&1 >/dev/tty)

    if [ -n "$seleccion" ]; then
   	 editor=$(command -v nano || command -v vi)
   	 "$editor" "${ruta}/${seleccion}"
    fi
}

crear_directorios() {
    ruta=$(dialog --inputbox "Introduce la ruta donde quieres crear los directorios:" 8 60 2>&1 >/dev/tty)
    if [ -z "$ruta" ]; then
   	 dialog --msgbox "Error: La ruta no puede estar vacía." 8 40
   	 return
    fi

    if [ ! -d "$ruta" ]; then
   	 dialog --msgbox "Error: La ruta especificada no existe." 8 40
   	 return
    fi

    nombre=$(dialog --inputbox "Introduce el nombre base para los directorios:" 8 60 2>&1 >/dev/tty)
    if [ -z "$nombre" ]; then
   	 dialog --msgbox "Error: El nombre base no puede estar vacío." 8 40
   	 return
    fi

    numero=$(dialog --inputbox "Introduce el número inicial para los directorios:" 8 60 2>&1 >/dev/tty)
    if [ -z "$numero" ]; then
   	 dialog --msgbox "Error: El número inicial no puede estar vacío." 8 40
   	 return
    fi

    cantidad=$(dialog --inputbox "Introduce la cantidad de directorios a crear:" 8 60 2>&1 >/dev/tty)
    if [ -z "$cantidad" ]; then
   	 dialog --msgbox "Error: La cantidad no puede estar vacía." 8 40
   	 return
    fi

    if [ ! -d "$ruta" ]; then
   	 mkdir -p "$ruta" || { dialog --msgbox "Error: No se pudo crear el directorio especificado." 8 40; return; }
    fi

    (
   	 for (( i = 1; i <= cantidad; i++ )); do
   		 mkdir -p "${ruta}/${nombre}${numero}" || { dialog --msgbox "Error: No se pudo crear el directorio." 8 40; return; }
   		 echo "$((i * 100 / cantidad))"
   		 ((numero++))
   		 sleep 0.1
   	 done
   	 echo "100"
    ) | dialog --gauge "Creando directorios en $ruta..." 8 70 0
    mandar_correo
}
definir_correo(){
	tempfile=$(mktemp)

	dialog --title "Introducir dirección de correo" --inputbox "Por favor, introduce tu dirección de correo:" 8 40 2> "$tempfile"

	if [ $? -eq 1 ]; then
    	dialog --msgbox "No se ha introducido ninguna dirección de correo." 6 40
    	rm -f "$tempfile"
    	return  # En lugar de salir, solo retornamos
	fi

	email=$(<"$tempfile")

	if [ -z "$email" ]; then
    	dialog --msgbox "No se ha introducido ninguna dirección de correo." 6 40
    	rm -f "$tempfile"
    	return  # Retornamos si no hay dirección de correo
	fi
    
	# Limpiar el archivo temporal
	rm -f "$tempfile"

}

while true; do
	mostrar_menu_principal
	opcion=$(<salida)

	case $opcion in
    	1) crear_ficheros ;;
    	2) crear_directorios ;;
    	3) if [ -n "$(find . -maxdepth 1 -name "*.txt" -print -quit)" ]; then editar_ficheros "." "*.txt"; else dialog --msgbox "No hay ficheros para editar." 8 40; fi ;;
    	4) definir_correo ;;
    	5) dialog --msgbox "Saliendo del programa." 8 40; exit ;;
    	*) dialog --msgbox "Opción no válida. Por favor, seleccione nuevamente." 8 40 ;;
	esac
done
