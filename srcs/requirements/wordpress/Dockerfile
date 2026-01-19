#  Use Bullseye
FROM debian:bullseye

# Install PHP 7.4
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-redis \
    wget \
    mariadb-client \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Fix the config path
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]