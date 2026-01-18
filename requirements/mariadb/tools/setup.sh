#!/bin/sh

# 1. Start by fixing permissions (Crucial!)
# Ensure the mysql user owns the data folder and the run folder
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "First start: initializing database"

    # Initialize data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start a temporary server to create users (Run as mysql user!)
    mysqld --user=mysql --skip-networking &
    pid="$!"
    
    # Wait for the temporary server to be ready
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Create users and database
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOF

    # Stop the temporary server properly
    kill "$pid"
    wait "$pid"
else
    echo "Database already initialized"
fi

# 2. THE MAIN FIX: Add '--user=mysql'
# This tells MariaDB: "Even though Docker is root, run this process as the mysql user."
exec mysqld --user=mysql