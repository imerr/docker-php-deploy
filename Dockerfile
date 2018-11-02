FROM php:7.2

RUN apt-get update && apt-get upgrade -y && \ 
  apt-get install -y ca-certificates wget zip unzip rsync git openssh-client \
  debconf-utils mariadb-server redis-server composer
