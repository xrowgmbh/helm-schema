#!/bin/bash
export DOCUMENT_ROOT=./public
export DOMAIN=schema.postcom.deutschepost.de
if [[ ${DOMAIN} != "schema.example.com" ]]; then
    for file in $(find ${DOCUMENT_ROOT}/ -maxdepth 3 -regextype posix-extended -iregex '.*[.]json' | sort -g); do 
        cat $file | sed -e "s/schema.example.com/${DOMAIN}/" 
        echo "Modified: $file"
    done
fi
exec "$@"