#!/bin/sh
set -eu

echo "Starting vsftpd service..."

: "${FTP_USER:?FTP_USER is required}"
: "${FTP_PASS:?FTP_PASS is required}"

FTP_HOME="/home/vsftpd"

if ! id -u "$FTP_USER" >/dev/null 2>&1; then
	useradd -d "$FTP_HOME" -s /bin/sh "$FTP_USER"
fi

mkdir -p "$FTP_HOME"
echo "$FTP_USER:$FTP_PASS" | chpasswd
chown -R "$FTP_USER:$FTP_USER" "$FTP_HOME"

exec vsftpd /etc/vsftpd.conf