#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

export SC_SUDO_USER="sendcode"

apt-get update

apt-get install -y software-properties-common curl git unzip zip

apt-get install -y nginx

mv /etc/nginx /etc/nginx-previous

git clone https://github.com/h5bp/server-configs-nginx.git /etc/nginx

cp /etc/nginx-previous/snippets/fastcgi-php.conf /etc/nginx/

cp /etc/nginx-previous/fastcgi.conf /etc/nginx/

sed -i "s/www-data/${SC_SUDO_USER}/g" /etc/nginx/nginx.conf;

ufw allow 80
ufw allow 443

systemctl start nginx

mkdir -p /home/${SC_SUDO_USER}/.logs
touch /home/${SC_SUDO_USER}/.logs/install-nginx-finished
chown -R ${SC_SUDO_USER}:${SC_SUDO_USER} /home/${SC_SUDO_USER}/.logs
