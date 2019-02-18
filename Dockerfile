FROM greyltc/archlinux:2017-11-20
MAINTAINER Grey Christoforo <grey@christoforo.net>

COPY local-setup/install-lamp.sh /usr/sbin/install-lamp
RUN install-lamp
COPY config.local.php config.php
COPY local-setup/db_dump.sql db_dump.sql

# generate our ssl key
ADD local-setup/setupApacheSSLKey.sh /usr/sbin/setup-apache-ssl-key

ARG SUBJECT
ARG DO_SSL_LETS_ENCRYPT_FETCH
ARG USE_EXISTING_LETS_ENCRYPT
ARG EMAIL
ARG DO_SSL_SELF_GENERATION

RUN setup-apache-ssl-key

# start servers
COPY local-setup/start-servers.sh /usr/sbin/start-servers
COPY local-setup/load-database.sh /usr/sbin/load-database
RUN load-database
CMD start-servers; sleep infinity
