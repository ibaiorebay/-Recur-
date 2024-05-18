#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Uso: $0 <direccion_de_correo>"
  exit 1
fi

SSMTP_CONFIG="/etc/ssmtp/ssmtp.conf"
TO=$1
FROM="noreplyrecur@example.com"
BODY="Recur ha finalizado de crear los ficheros o directorios pedidos!"

EMAIL_CONTENT=$(mktemp)
cat <<EOF > "$EMAIL_CONTENT"
${BODY}"
EOF
ssmtp "$TO" < "$EMAIL_CONTENT"



