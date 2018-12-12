FROM php:5.6-apache

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /

RUN apt-get -qq update > /dev/null &&\
    apt-get -qq -y --no-install-recommends install wget unzip > /dev/null &&\
    # Jorani installation
    rm -Rf /var/www/html &&\
    wget -O jorani.tar.gz https://github.com/bbalet/jorani/releases/download/v0.6.5/jorani-0.6.5.zip &&\
    unzip jorani.tar.gz &&\
    mv jorani /var/www/html &&\
    a2enmod rewrite &&\
    docker-php-ext-install pdo_mysql &&\
    #Cleanup
    apt-get remove -qq -y wget unzip &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD rootfs /
