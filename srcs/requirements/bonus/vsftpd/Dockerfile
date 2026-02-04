FROM debian:bullseye

RUN apt update && apt install -y sudo vsftpd ftp iputils-ping \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY conf/user.sh /usr/local/bin/user.sh

RUN mkdir -p /var/run/vsftpd/empty

RUN chmod 755 /var/run/vsftpd/empty

RUN chmod +x /usr/local/bin/user.sh

ENTRYPOINT ["/usr/local/bin/user.sh"]