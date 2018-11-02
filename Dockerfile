FROM php:7.2

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get upgrade -y && \ 
  apt-get install -y ca-certificates wget zip unzip rsync git openssh-client \
  debconf-utils mariadb-server redis-server composer nodejs
