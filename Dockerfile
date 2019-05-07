FROM php:7.2

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y ca-certificates wget zip unzip rsync git openssh-client \
  debconf-utils mariadb-server redis-server gnupg libzip-dev libfreetype6-dev \
  libgd-dev libpng-dev libjpeg62-turbo-dev libwebp-dev libc-client2007e \
  ca-certificates wget unzip git python3 python3-pip rsync openssh-client && \
  pip3 install ansible && \
  docker-php-ext-install -j$(nproc) zip && \
  docker-php-ext-install -j$(nproc) pdo_mysql && \
  docker-php-ext-install -j$(nproc) gd && \
  docker-php-ext-install -j$(nproc) imap && \
  docker-php-ext-install -j$(nproc) bcmath

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -  && apt-get install -y nodejs
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
  php composer-setup.php --install-dir=/bin --filename=composer && \
  php -r "unlink('composer-setup.php');"
