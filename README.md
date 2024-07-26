Deploy PHP

### Usage

Run the command below as root.

```bash
wget -O security-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/app-setup.sh
```

> You will be asked for an SSH public key. After installation, you will not be able to SSH into your server using root or password. You can only access using your SSH private key that associate with the SSH public key you added.

This command does lots of things but your just need to care 2 for now:
- It installs Nginx and PHP 8.3.
- It creates the "sendcode" user to run sudo commands without password prompt.
- It creates the "vito" user to serve you PHP applications.

After it's finished, use this command to access your server:

```bash
# A new sudo user already added called "sendcode".
ssh -i /path/to/your/key.pem sendcode@your-ip-address
```

You are now logged in your server as "sendcode" user.

```bash
# Log in as "vito".
sudo su vito

# Write sample source code.
mkdir ~/demo.test/public -p
echo '<?php phpinfo();' > ~/demo.test/public/index.php

exit # go back with the "sendcode" login session.

# Download the site-setup.sh script then run it.
wget -O site-setup.sh https://raw.githubusercontent.com/confetticode/deploy-php/master/scripts/site-setup.sh

# You will be ask for domain, webroot and PHP version.
# domain: demo.test
# webroot: /home/vito/demo.test/public
# php: 8.3
sudo bash site-setup.sh
```

> Replace "demo.test" with your specific user and point your domain to your server IP address.

You may wait for a while due to your domain provider. Then, when visiting http://demo.test, you should see a PHP info page.
