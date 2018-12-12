FROM php:5.6-apache

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /

RUN apt-get -qq update > /dev/null &&\
    apt-get -qq -y --no-install-recommends install wget  > /dev/null &&\
    # Jorani installation
    rm -Rf /var/www/html &&\
    wget -O jorani.tar.gz https://github.com/bbalet/jorani/archive/v0.6.5.tar.gz &&\
    tar xf jorani.tar.gz &&\
    mv jorani-0.6.5 /var/www/html &&\
    a2enmod rewrite &&\
    docker-php-ext-install pdo_mysql &&\
    #Cleanup
    apt-get remove -qq -y curl &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD rootfs /
