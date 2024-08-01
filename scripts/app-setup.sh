#!/usr/bin/env bash

wget -O security-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/security-setup.sh
wget -O nginx-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/nginx-setup.sh
wget -O php-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/php-setup.sh

chmod +x security-setup.sh
chmod +x nginx-setup.sh
chmod +x php-setup.sh

./security-setup.sh
./nginx-setup.sh
./php-setup.sh

rm -rf {security,nginx,php}-setup.sh
