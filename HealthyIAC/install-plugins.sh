#!/bin/bash
# Script compatible con Windows/Linux para instalar plugins
set -e

# Ruta correcta del instalador de plugins en la imagen oficial
JENKINS_CLI="/usr/local/bin/jenkins-plugin-cli"

# Verificar si el instalador existe
if [ ! -f "$JENKINS_CLI" ]; then
    echo "Error: Jenkins plugin CLI no encontrado en $JENKINS_CLI"
    exit 1
fi

# Instalar cada plugin
while IFS= read -r plugin || [ -n "$plugin" ]; do
    plugin=$(echo "$plugin" | tr -d '\r' | xargs)
    if [ -z "$plugin" ]; then
        continue
    fi
    echo "Instalando plugin: $plugin"
    "$JENKINS_CLI" --plugins "$plugin"
done < "$1"