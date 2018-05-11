FROM debian:stable

RUN apt-get update && apt-get upgrade -y && \ 
  apt-get install -y ca-certificates wget zip unzip rsync git php7.0-cli php7.0-mysql php7.0-mbstring php7.0-xml openssh-client \
  debconf-utils mariadb-server redis-server
