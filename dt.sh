#!/bin/bash

# Verifica se os argumentos foram fornecidos corretamente
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <language> <api-key> <project-id>"
    exit 1
fi

# Extrai os argumentos
language=$1
api_key=$2
project_id=$3

# Instalação do Node.js e npm
sudo su
sudo apt update
sudo apt install ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs

# Instalação do cdxgen
npm install -g @cyclonedx/cdxgen

# Comando para gerar o SBOM
cdxgen -t $language . --server-url https://sbom-api.4intelligence.com.br --api-key $api_key --project-id $project_id