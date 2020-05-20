#!/bin/sh

# File
# Self-contained install script
#
# Clones and bootstraps the dotfiles project. Needs to be self-contained for
# download and cannot include libraries. It will try to use the minimum number
# of dependencies to install the dotfiles project. YADM will then take over
# to bootstrap the project.

set -e

# Defaults
REMOTE=${REMOTE:-"https://gitlab.com/andycarlberg/dotfiles.git"}

[ $(id -u) -eq 0 ] && IS_ROOT=0 || IS_ROOT=1

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

install_git() {
  command_exists pacman && {
    pacman -Syu git && {
      return 0
    }
  }

  command_exists sudo && command_exists apt && {
    sudo apt install git && {
      return 0
    }
  }

  echo "Git install failed. Install Git manually before running dotfiles install."
  exit 1
}

# Install YADM.
#
# Installs Yet Another Dotfiles Manager via a hierarchy of preferred methods.
# This function will try to install YADM in the preferred way for the OS,
# defaulting to manual install if no other method is found.
install_yadm() {
  command_exists pacman && {
    pacman -Syu yadm-git && {
      return 0
    }
  }

  command_exists apt && {
    sudo apt install yadm && {
      return 0
    }
  }

  command_exists brew && {
    brew install yadm && {
      return 0
    }
  }

  curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm && {
    return 0
  }

  echo "YADM install failed. Install YADM manually before running dotfiles install."
  exit 1
}

main() {
  echo "Beginning environment setup..."

  command_exists git || {
    echo "Git is not installed."
    echo "Attempting to install Git..."
    install_git
  }

  command_exists yadm || {
    echo "YADM is not installed."
    echo "Attempting to install YADM..."
    install_yadm
  }

  yadm clone $REMOTE --bootstrap
}

if [ $IS_ROOT -eq 0 ]; then
  echo "Don't run this as root!"
  exit 1
fi

main "$@"
