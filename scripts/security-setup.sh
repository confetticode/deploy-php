#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

# The root alternative user that you can run "sudo" commands without password prompt.
export SC_SUDO_USER="sendcode"

# The SSH port should be configured.
export SC_SSH_PORT=22

# The SSH public key you use to access to the server.
# Eg: from you MacBook Pro, you can run "ssh -i ~/.ssh/your-private-key.pem sendcode@your-server-ip"
# export SC_SSH_PUB_KEY=""

###ENVIRONMENT_VARIABLES###

if [[ -z "${SC_SSH_PUB_KEY}" ]]; then
  echo "Please enter your SSH public key:"
  read SC_SSH_PUB_KEY
fi

##### Create a new sudo user (instead of using the root) #####
if id "${SC_SUDO_USER}" >/dev/null 2>&1; then
    echo "The user \"${SC_SUDO_USER}\" already exists"
else
    adduser --disabled-password --gecos "The root alternative" ${SC_SUDO_USER}
fi

usermod -aG sudo ${SC_SUDO_USER}
echo "${SC_SUDO_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${SC_SUDO_USER}

mkdir -p /home/${SC_SUDO_USER}/.ssh

file=/home/${SC_SUDO_USER}/.ssh/authorized_keys
search_string="${SC_SSH_PUB_KEY}"
if grep -q "$search_string" "$file" 2>/dev/null ; then
    echo "The SSH public key already exists"
else
    echo "${SC_SSH_PUB_KEY}" >> /home/${SC_SUDO_USER}/.ssh/authorized_keys
fi

chown -R ${SC_SUDO_USER}:${SC_SUDO_USER} /home/${SC_SUDO_USER}/.ssh

##### Configure SSH (/etc/sshd_config) #####
rm -rf /etc/ssh/sshd_config.d/*

touch /etc/ssh/sshd_config.d/50-cloud-init.conf

chmod 600 /etc/ssh/sshd_config.d/50-cloud-init.conf

# TODO: we should only allow users in sendcode group to SSH.
export SC_SSHD_CONFIG="Port ${SC_SSH_PORT}
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
PubkeyAuthentication yes

# AllowGroups sendcode ssh"
if ! echo "${SC_SSHD_CONFIG}" | tee /etc/ssh/sshd_config.d/50-cloud-init.conf; then
    echo "Can't configure SSH!" && exit 1
fi

systemctl restart sshd

ufw allow ${SC_SSH_PORT}

echo "y" | sudo ufw enable

##### Install and configure fail2ban #####

sudo apt-get update

sudo apt-get install -y fail2ban

systemctl restart fail2ban

mkdir -p /home/${SC_SUDO_USER}/.logs
touch /home/${SC_SUDO_USER}/.logs/security-setup-finished
chown -R ${SC_SUDO_USER}:${SC_SUDO_USER} /home/${SC_SUDO_USER}/.logs
