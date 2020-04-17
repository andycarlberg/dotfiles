#!/bin/sh

# File
# Utility library for dotfiles install and related scripts

# Check if a command or application is installed.
command_exists() {
  command -v "$@" > /dev/null 2>&1
}

# Install Git.
#
# Git is a dependency for a lot of the tools. This provides a consistent install script for use by modules.
install_git() {
  sudo apt install git || {
    echo "Git install failed. Install Git manually before running dotfiles install."
    exit 1
  }
  echo "Git successfully installed."
}

