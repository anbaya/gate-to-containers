FROM debian:bullseye

RUN apt update && apt install -y \
    mariadb-server mariadb-client

COPY tools/mariadb.cnf /etc/mysql/mariadb.cnf

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]