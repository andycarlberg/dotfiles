#!/bin/sh

# File
# Utility library for dotfiles install and related scripts

# Check if a command or application is installed.
command_exists() {
  command -v "$@" > /dev/null 2>&1
}

# Install an application.
#
# Check if an application is already installed. If not, install it using a method appropriate for the OS.
#
# $1 application name
# $2 executable command (optional, if different)
install() {
  local command="${2:-$1}"
  command_exists $command || {
    echo "$1 is not installed."
    echo "Attempting to install $1..."
    sudo apt install $1 -y || {
      echo "Install failed. Install $1 manually."
      exit 1
    }
    echo "$1 successfully installed."
  }
}
