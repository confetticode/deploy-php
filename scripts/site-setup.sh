#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

#export SC_SITE_DOMAIN="demo.test"
#export SC_SITE_WEBROOT="/home/vito/demo.test/public"
export SC_SITE_PHP="8.3"

###ENVIRONMENT_VARIABLES###

if [[ -z "${SC_SITE_DOMAIN}" ]]; then
  echo "Please enter the site domain:"
  read SC_SITE_DOMAIN
fi

if [[ -z "${SC_SITE_WEBROOT}" ]]; then
  echo "Please enter the site webroot (Eg: /home/vito/${SC_SITE_DOMAIN}/public):"
  read SC_SITE_WEBROOT
fi

if [[ -z "${SC_SITE_PHP}" ]]; then
  echo "Please enter the site PHP version (Eg: 8.3):"
  read SC_SITE_PHP
fi

if [ ! -d "${SC_SITE_WEBROOT}" ]; then
  echo "[${SC_SITE_WEBROOT}] does NOT exist or is NOT a directory."
  exit 1
fi

mkdir -p "/var/log/nginx/${SC_SITE_DOMAIN}"

export SC_SITE_CONFIG="server {
 listen [::]:80;
 listen 80;

 # The host name to respond to
 server_name ${SC_SITE_DOMAIN};

 # The root directory
 root ${SC_SITE_WEBROOT};

 # Write logs to specific files
 access_log  /var/log/nginx/${SC_SITE_DOMAIN}/access.log;
 error_log  /var/log/nginx/${SC_SITE_DOMAIN}/error.log;

 # Run index.php with a specific PHP-FPM version.
   location ~ \.php$ {
       include fastcgi-php.conf;
       fastcgi_pass unix:/run/php/php${SC_SITE_PHP}-fpm.sock;
   }

 # The file should be served by default
 index index.html index.htm index.php;

 # Let index.php handle 404 error.
 error_page 404 /index.php;

 # Include the basic h5bp config set
 include h5bp/basic.conf;

 # Ignore /favicon.ico and /robots.txt requests
 location = /favicon.ico { log_not_found off; access_log off; }
 location = /robots.txt  { log_not_found off; access_log off; }

 # Deny requests to .ht files.
 location ~ /\.ht {
   deny all;
 }

 # If a directory or file exists, serve it.
 # Else, try to run index.php.
 # Otherwise, fail with 404 status code.
 location / {
   try_files \$uri \$uri/ /index.php\$is_args\$args =404;
 }
}"
if ! echo "${SC_SITE_CONFIG}" | tee "/etc/nginx/conf.d/${SC_SITE_DOMAIN}.conf"; then
    echo "Can NOT setup site!" && exit 1
fi

# TODO: Do I have to restart Nginx and PHP FPM? Or reloading is enough?
systemctl restart nginx
systemctl restart "php${SC_SITE_PHP}-fpm"
