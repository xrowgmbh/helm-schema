#!/bin/bash

if [[ ${DOMAIN} != "schema.example.com" ]]; then
    for file in $(find ${DOCUMENT_ROOT}/ -maxdepth 3 -regextype posix-extended -iregex '.*[.]json' | sort -g); do 
        sed -i "s/schema.example.com/${DOMAIN}/" $file
        echo "Modified: $file"
    done
fi
openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -sha256 -days 3650 -nodes -subj "/CN=${DOMAIN}" -addext "subjectAltName=DNS:${DOMAIN},DNS:localhost,IP:127.0.0.1"

mv server.crt /usr/local/apache2/conf/server.crt
mv server.key /usr/local/apache2/conf/server.key

exec "$@"