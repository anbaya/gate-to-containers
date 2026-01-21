FROM debian:bullseye

RUN apt update && apt install -y sudo vsftpd ftp iputils-ping

RUN useradd -m ftpuser \
    && echo "ftpuser:password" | chpasswd

COPY conf/vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty

RUN chmod 755 /var/run/vsftpd/empty

CMD ["vsftpd", "/etc/vsftpd.conf"]
