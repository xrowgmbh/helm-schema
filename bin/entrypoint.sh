#!/bin/bash

if [[ ${DOMAIN} != "schema.example.com" ]]; then
    for file in $(find ${DOCUMENT_ROOT}/ -maxdepth 3 -regextype posix-extended -iregex '.*[.]json' | sort -g); do 
        sed -i "s/schema.example.com/${DOMAIN}/" $file
        echo "Modified: $file"
    done
fi
exec "$@"