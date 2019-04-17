FROM alpine:3.9
LABEL Maintainer="namcx" \
      Description="lighweight image php+nginx alpine"

# Install packages
RUN apk add --no-cache --virtual .build-deps \
    php php-fpm php-mysqli php-json php-openssl php-curl \
    php-zlib php-xml php-phar php-intl php-dom php-xmlreader php-ctype \
    php-mbstring php-gd nginx supervisor curl

#RUN apk del .build-deps

# Nginx & PHP & Supervisor configuration
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/php/php.ini /etc/php7/php.ini
#COPY conf/php/cli.php.ini /etc/php7/cli/php.ini
COPY config/php/php-fpm.conf /etc/php7/php-fpm.conf
COPY config/php/www.conf /etc/php7/php-fpm.d/www.conf

COPY config/supervisord.conf /etc/supervisord.conf

# Forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log

#Test PHP
COPY ./info.php /src/public/index.php

#Star supervisord
COPY ./start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 8080

CMD ["/bin/ash", "/start.sh"]
