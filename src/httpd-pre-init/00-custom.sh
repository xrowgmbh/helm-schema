#!/bin/bash
echo "Doing customization"

mkdir -p /opt/app-root/src/httpd-cfg

cat <<\EOF > /opt/app-root/src/httpd-cfg/settings.conf 
DocumentRoot /opt/app-root/src/public
<Directory /opt/app-root/src>
    Options +Indexes
    Options +FollowSymLinks
    Options +MultiViews
    AllowOverride all
</Directory>
EOF

if [[ "${DOMAIN}" != "" ]]; then
    echo "Generate cert for ${DOMAIN}"
    mkdir -p /opt/app-root/src/httpd-ssl/certs
    mkdir -p /opt/app-root/src/httpd-ssl/private
    openssl req -x509 -newkey rsa:4096 -keyout /opt/app-root/src/httpd-ssl/private/${DOMAIN}.pem -out /opt/app-root/src/httpd-ssl/certs/${DOMAIN}.pem -sha256 -days 3650 -nodes -subj "/CN=${DOMAIN}" -addext "subjectAltName=DNS:${DOMAIN},DNS:${DOMAIN}:8443,DNS:${DOMAIN}:443,DNS:localhost,IP:127.0.0.1"
fi
if [[ ${DOMAIN} != "schema.example.com" ]]; then
    for file in $(find ${DOCUMENT_ROOT}/ -maxdepth 3 -regextype posix-extended -iregex '.*[.]json' | sort -g); do 
        sed -i "s/schema.example.com/${DOMAIN}/" $file
        echo "Modified: $file"
    done
fi