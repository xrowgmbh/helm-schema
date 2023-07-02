    openssl req -x509 -newkey rsa:4096 -keyout ./httpd-ssl/certs/${DOMAIN}.pem -out ./httpd-ssl/private/${DOMAIN}.pem -sha256 -days 3650 -nodes -subj "/CN=${DOMAIN}" -addext "subjectAltName=DNS:${DOMAIN},DNS:${DOMAIN}:8443,DNS:${DOMAIN}:443,DNS:localhost,IP:127.0.0.1"
    mkdir -p ./httpd-ssl/certs
    mkdir -p ./httpd-ssl/private
    openssl req -x509 -newkey rsa:4096 -keyout ./httpd-ssl/certs/${DOMAIN}.pem -out ./httpd-ssl/private/${DOMAIN}.pem -sha256 -days 3650 -nodes -subj "/CN=${DOMAIN}" -addext "subjectAltName=DNS:${DOMAIN},DNS:${DOMAIN}:8443,DNS:${DOMAIN}:443,DNS:localhost,IP:127.0.0.1"
cat ./httpd-ssl/certs/schema.example.com.pem
exit
ls -lisa
ls -lisa /opt/app-root/
exit
ls -lisa /opt/app-root/
exit
