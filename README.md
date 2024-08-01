# Deploy PHP

### Usage

Image you've created a fresh Ubuntu server and can SSH into it.

On that server, run the command below as root.

```bash
wget -O security-setup.sh https://raw.githubusercontent.com/sendcode-project/deploy-php/master/scripts/app-setup.sh
```

> You will be asked for a password and an SSH public key. After installation, you will not be able to SSH into your server using root or password. You can only access using your SSH private key that associate with the SSH public key you added.


- It installs Nginx and PHP 8.3.
- It creates the "forge" user to run sudo commands.

After finishing, on your computer, use this command to SSH into your server.

```bash
ssh -i /path/to/your/key.pem forge@server-ip-address
```

You are now logged in your server as "forge" user and can create a PHP site using the sample below.

```bash
mkdir ~/demo.test/public -p

echo '<?php phpinfo();' > ~/demo.test/public/index.php


# Download the site-setup.sh script then run it.
wget -O site-setup.sh https://raw.githubusercontent.com/sendcode-project/deploy-php/master/scripts/site-setup.sh

# You will be ask for domain, webroot and PHP version.
# domain: demo.test
# webroot: /home/forge/demo.test/public
# php: 8.3
sudo bash site-setup.sh
```

> Replace "demo.test" with your specific user and point your domain to your server IP address.

You may wait for a while due to your domain provider. Then, when visiting http://demo.test, you should see a PHP info page.
