#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

export SC_SUDO_USER="forge"

###ENVIRONMENT_VARIABLES###

apt-get update

apt-get install -y software-properties-common curl git unzip zip

apt-get install -y nginx

# TODO: Should we force to re-configure?
mv /etc/nginx /etc/nginx-previous-"$(date -u +%s)"

git clone https://github.com/sendcode-project/server-configs-nginx.git /etc/nginx

sed -i "s/www-data/${SC_SUDO_USER}/g" /etc/nginx/nginx.conf;

ufw allow 80
ufw allow 443

systemctl restart nginx

mkdir -p /home/${SC_SUDO_USER}/.logs
touch /home/${SC_SUDO_USER}/.logs/nginx-setup-finished
chown -R ${SC_SUDO_USER}:${SC_SUDO_USER} /home/${SC_SUDO_USER}/.logs
