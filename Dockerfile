FROM php:7.2

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y ca-certificates wget zip unzip rsync git openssh-client \
  debconf-utils mariadb-server redis-server gnupg libzip-dev libfreetype6-dev \
  libgd-dev libpng-dev libjpeg62-turbo-dev libwebp-dev libc-client2007e-dev \
  ca-certificates wget unzip git python3 python3-pip rsync openssh-client \
  libkrb5-dev libkrb5-dev libmcrypt-dev libc-client2007e libc-client-dev libssl-dev && \
  pip3 install ansible && \
  docker-php-ext-install -j$(nproc) zip && \
  docker-php-ext-install -j$(nproc) pdo_mysql && \
  docker-php-ext-install -j$(nproc) gd && \
  docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
  docker-php-ext-install -j$(nproc) imap && \
  docker-php-ext-install -j$(nproc) bcmath && \
  apt-get -y install zip wget unzip xdg-utils \
    libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4 xvfb \
    gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi xfonts-75dpi \
    xfonts-base xfonts-scalable x11-apps && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i --force-depends google-chrome-stable_current_amd64.deb && \
  apt-get -y -f install && \
  dpkg -i --force-depends google-chrome-stable_current_amd64.deb && \
  rm google-chrome-stable_current_amd64.deb && \
  wget https://chromedriver.storage.googleapis.com/`curl http://chromedriver.chromium.org/home -s | sed -n -r -e 's/.+Latest stable release:.+\?path=([0-9.]+).*Latest beta.*/\1/p'`/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/ && \
  rm chromedriver_linux64.zip

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -  && apt-get install -y nodejs
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
  php composer-setup.php --install-dir=/bin --filename=composer && \
  php -r "unlink('composer-setup.php');"
