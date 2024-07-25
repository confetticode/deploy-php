#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

export SC_SUDO_USER="sendcode"
export SC_USER="vito"

# Eg: Create a new user called "vito" with "sendcode" as the default group.
adduser --disabled-password --gecos "${SC_USER} belongs to ${SC_SUDO_USER} group" "${SC_USER}"
usermod -g ${SC_SUDO_USER} "${SC_USER}"

# TODO: Generate password for "vito" user if needed.
# usermod --password $(echo "${SC_USER}_PASSWORD" | openssl passwd -1 -stdin) "${SC_USER}"

# TODO: Configure SSH for "vito" user if needed.
# chown -R "${SC_USER}:${SC_SUDO_USER}" "/home/${SC_USER}/.ssh"
