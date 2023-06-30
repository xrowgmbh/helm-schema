#!/bin/bash

if [[ "${DOMAIN}" != "" ]]; then
    echo "Generate cert for ${DOMAIN}"
    mkdir -p ./httpd-ssl/certs
    mkdir -p ./httpd-ssl/private
    openssl req -x509 -newkey rsa:4096 -keyout ./httpd-ssl/private/server.pem -out ./httpd-ssl/certs/server-cert-selfsigned.pem -sha256 -days 3650 -nodes -subj "/CN=${DOMAIN}" -addext "subjectAltName=DNS:${DOMAIN},DNS:localhost,IP:127.0.0.1"
fi
if [[ ${DOMAIN} != "schema.example.com" ]]; then
    for file in $(find ${DOCUMENT_ROOT}/ -maxdepth 3 -regextype posix-extended -iregex '.*[.]json' | sort -g); do 
        sed -i "s/schema.example.com/${DOMAIN}/" $file
        echo "Modified: $file"
    done
fi