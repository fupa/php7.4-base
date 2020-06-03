FROM php:7.4.6-fpm

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get autoremove -y && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y
RUN apt-get install -y \
    curl  \
    zlib1g-dev \
    libzip-dev

RUN pecl channel-update pecl.php.net
RUN docker-php-ext-install zip opcache

RUN pecl install redis && docker-php-ext-enable redis
RUN docker-php-ext-install pdo pdo_mysql mysqli pcntl

RUN apt-get clean

WORKDIR /var/www/html

EXPOSE 80