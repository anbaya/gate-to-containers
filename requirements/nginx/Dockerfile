FROM debian:bullseye
# 1. Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# 2. Generate SSL Certificate (Required for HTTPS)
# This creates a self-signed cert for 'login.42.fr'
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MO/L=KH/O=42/OU=student/CN=login.42.fr"

# 3. Copy your NGINX config file
COPY conf/nginx.conf /etc/nginx/conf.d/myserver.conf

# 4. Remove the default config (The "Welcome to Nginx" Fix)
RUN rm /etc/nginx/sites-enabled/default

# 5. Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]