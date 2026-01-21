FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	curl \
	vim
RUN rm var/www/html/*

COPY index.html var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
