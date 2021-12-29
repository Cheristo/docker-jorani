FROM php:7.4-apache

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /

RUN apt-get -qq update > /dev/null &&\
    apt-get -qq -y --no-install-recommends install wget unzip > /dev/null &&\
    # Jorani installation
    rm -Rf /var/www/html &&\
    wget -O jorani.tar.gz https://github.com/bbalet/jorani/releases/download/v1.0.0/jorani-1.0.0.zip &&\
    mkdir /jorani
    unzip jorani.tar.gz -d /jorani &&\
    mv jorani /var/www/html &&\
    a2enmod rewrite &&\
    docker-php-ext-install pdo_mysql &&\
    #Cleanup
    apt-get remove -qq -y wget unzip &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD rootfs /
