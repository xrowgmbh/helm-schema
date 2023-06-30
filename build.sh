#!/bin/bash

source /etc/environment

if [[ -v RH_REGISTRY_ACCOUNT && -v RH_REGISTRY_PASSWORD ]]; then
  echo "Login into RH registry registry.redhat.io ..."
  echo "${RH_REGISTRY_PASSWORD}" | podman login -u ${RH_REGISTRY_ACCOUNT} --password-stdin registry.redhat.io
else
  echo "RH_REGISTRY_ACCOUNT adn RH_REGISTRY_PASSWORD is not set. registry.redhat.io will be not available."
fi

export DOMAIN="schema.example.com"

podman stop schema || true
podman rm schema || true
podman build -t schema .
podman run -d --name schema -v $(pwd)/public/:/var/www/:z -p 443:8443 -p 80:8080 schema
curl --head -X GET --retry 10 --retry-connrefused --retry-delay 2 --fail http://localhost:80
openssl s_client -showcerts -connect localhost:443 </dev/null 2>/dev/null|openssl x509 -outform PEM > /etc/pki/ca-trust/source/anchors/server.crt
update-ca-trust
grep -qF -- "127.0.0.1 ${DOMAIN}" "/etc/hosts" || echo "127.0.0.1 ${DOMAIN}" >> "/etc/hosts"

echo "Ready, now run: helm lint schema-test/"