#!/bin/bash
cd /var/www/html

echo "Waiting for MariaDB..."
while ! mariadb-admin ping -h"mariadb" --silent; do
    sleep 1
done
echo "MariaDB is up!"
echo "Waiting for Redis..."
while [ "$(redis-cli -h redis ping)" != "PONG" ]; do
  sleep 1
done

echo "Redis is up and running!"

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress not found. Installing..."
    
    # 1. Download (Ignore error if files exist)
    wp core download --allow-root || true

    # 2. Create Config (This fills the database form for you)
    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb" \
        --path='/var/www/html'

    # Add fix for Nginx SSL handling
    # wp config set FORCE_SSL_ADMIN true --raw --allow-root --path='/var/www/html'
    # wp config set $_SERVER['HTTPS'] 'on' --raw --allow-root --path='/var/www/html'

    # 2. Add Redis Settings (The Bonus Part)
    wp config set WP_REDIS_HOST redis --allow-root --path='/var/www/html'
    wp config set WP_REDIS_PORT 6379 --raw --allow-root --path='/var/www/html'
    wp config set WP_CACHE true --raw --allow-root --path='/var/www/html'

    # 3. Install (This creates the admin user and site title)
    wp core install \
        --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
        
    # 4. Create a second user (Required by subject)
    wp user create \
        --allow-root \
        "$WP_USER" "$WP_EMAIL" \
        --user_pass="$WP_PASSWORD" \
        --role=author
fi

chown -R www-data:www-data /var/www/html

echo "Starting PHP..."
exec /usr/sbin/php-fpm7.4 -F