FROM debian:bullseye

# Install PHP
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://www.adminer.org/latest.php -O index.php

CMD ["php", "-S", "0.0.0.0:8080"]