#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

export SC_SUDO_USER="sendcode"
export SC_USER="vito"
export SC_PASS="secret"

###ENVIRONMENT_VARIABLES###

# Eg: Create a new user called "vito" with "sendcode" as the default group.
if id "${SC_USER}" >/dev/null 2>&1; then
    echo "The user \"${SC_USER}\" already exists"
else
    adduser --disabled-password --gecos "${SC_USER} belongs to ${SC_SUDO_USER} group" "${SC_USER}"
fi

usermod -g ${SC_SUDO_USER} "${SC_USER}"

 usermod --password $(echo "${SC_PASS}" | openssl passwd -1 -stdin) "${SC_USER}"

CS_HOSTNAME=$(hostname)

trimmed_string=$(echo "${CS_HOSTNAME}" | tr -d ' ')

# Generate SSH key pair
if [ -f /home/${SC_USER}/.ssh/id_ed25519 ]; then
  ssh-keygen -y -f /home/${SC_USER}/.ssh/id_ed25519 > /home/${SC_USER}/.ssh/id_ed25519.pub
else
  mkdir -p /home/${SC_USER}/.ssh
  ssh-keygen -t ed25519 -N '' -C "${SC_USER}@${trimmed_string}" -f /home/${SC_USER}/.ssh/id_ed25519
fi

chown -R "${SC_USER}:${SC_SUDO_USER}" "/home/${SC_USER}/.ssh"
