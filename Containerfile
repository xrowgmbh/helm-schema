FROM docker.io/httpd:2.4

ENV DOMAIN=schema.example.com
ENV DOCUMENT_ROOT=/usr/local/apache2/htdocs

COPY ./public/ ${DOCUMENT_ROOT}/
COPY server.crt /usr/local/apache2/conf/server.crt
COPY server.key /usr/local/apache2/conf/server.key
COPY bin/entrypoint.sh /bin/entrypoint.sh

RUN sed -i \
		-e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
		-e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
		-e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
		conf/httpd.conf

ENTRYPOINT ["/bin/entrypoint.sh"]