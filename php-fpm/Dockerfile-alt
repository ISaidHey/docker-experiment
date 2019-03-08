FROM php:7.3-fpm-alpine

ENV FPM_CONF /usr/local/etc/php-fpm.d/www.conf

RUN apk update

# Installs extra extensions and library depedencies
RUN apk add \
      autoconf \
      curl \
      g++ \
      git \
      libmcrypt-dev \
      libzip-dev \
      make \
      openssl-dev \
      postgresql-dev \
      sqlite-dev \
      unzip \
      vim \
      zlib-dev \
    && pecl install \
      mcrypt-1.0.2 \
      mongodb \
    && docker-php-ext-install \
      json \
      mysqli \
      opcache \
      pdo_mysql \
      pdo_pgsql \
      pdo_sqlite \
      pgsql \
      sockets \
      zip \
    && docker-php-ext-enable mcrypt

# install composer
RUN sh -c "curl -o /usr/local/bin/composer http://getcomposer.org/composer.phar && chmod a+x /usr/local/bin/composer"

# enable mongodb extension
RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini

COPY docker-vars.ini /usr/local/etc/php/conf.d/docker-vars.ini

## config default fpm
#RUN sed -i \
#        -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
#        -e "s/pm.max_children = 5/pm.max_children = 4/g" \
#        -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
#        -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
#        -e "s/user = www-data/user = nginx/g" \
#        -e "s/group = www-data/group = nginx/g" \
#        -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
#        -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
#        -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
#        -e "s/;listen.owner = www-data/listen.owner = nginx/g" \
#        -e "s/;listen.group = www-data/listen.group = nginx/g" \
#        -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
#        -e "s/^;clear_env = no$/clear_env = no/" \
#        ${FPM_CONF}