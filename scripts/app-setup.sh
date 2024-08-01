#!/usr/bin/env bash

wget -O security-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/security-setup.sh

bash security-setup.sh

wget -O nginx-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/nginx-setup.sh

bash nginx-setup.sh

wget -O php-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/php-setup.sh

bash php-setup.sh

rm -rf {security,nginx,php}-setup.sh
