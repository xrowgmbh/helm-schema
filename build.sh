#!/bin/bash

export DOMAIN="schema.example.com"

podman stop schema || true
podman rm schema || true
podman build -t schema .
podman run -d --name schema -u root -v $(pwd)/public/:/usr/local/apache2/htdocs/:z -p 443:443 -p 80:80 schema
curl --head -X GET --retry 10 --retry-connrefused --retry-delay 2 --fail http://localhost:80
openssl s_client -showcerts -connect localhost:443 </dev/null 2>/dev/null|openssl x509 -outform PEM > /etc/pki/ca-trust/source/anchors/server.crt
update-ca-trust
grep -qF -- "127.0.0.1 ${DOMAIN}" "/etc/hosts" || echo "127.0.0.1 ${DOMAIN}" >> "/etc/hosts"

echo "Ready, now run: helm lint schema-test/"