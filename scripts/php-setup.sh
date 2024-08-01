#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

export SC_SUDO_USER="forge"
export SC_PHP_VERSION="8.3"

###ENVIRONMENT_VARIABLES###

add-apt-repository -y ppa:ondrej/php

apt-get update

apt-get install -y software-properties-common curl git unzip zip

apt-get install -y \
        php${SC_PHP_VERSION}-fpm \
        php${SC_PHP_VERSION}-cli \
        php${SC_PHP_VERSION}-mcrypt \
        php${SC_PHP_VERSION}-gd \
        php${SC_PHP_VERSION}-mysql \
        php${SC_PHP_VERSION}-pgsql \
        php${SC_PHP_VERSION}-imap \
        php-memcached \
        php${SC_PHP_VERSION}-mbstring \
        php${SC_PHP_VERSION}-xml \
        php${SC_PHP_VERSION}-curl \
        php${SC_PHP_VERSION}-sqlite3

php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

sed -i "s/www-data/${SC_SUDO_USER}/g" "/etc/php/${SC_PHP_VERSION}/fpm/pool.d/www.conf";

systemctl restart php${SC_PHP_VERSION}-fpm

mkdir -p /home/${SC_SUDO_USER}/.logs
touch /home/${SC_SUDO_USER}/.logs/php-setup-finished
chown -R ${SC_SUDO_USER}:${SC_SUDO_USER} /home/${SC_SUDO_USER}/.logs
