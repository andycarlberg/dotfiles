#!/bin/sh
set -e

# Defaults
DOTFILES=${DOTFILES:-"${HOME}/.dotfiles"}
REMOTE=${REMOTE:-"https://gitlab.com/andycarlberg/dotfiles.git"}
BRANCH=${BRANCH:-"master"}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

install_git() {
    sudo apt install git || {
        echo "Git install failed. Install Git manually before running dotfiles install."
        exit 1
    }
    echo "Git successfully installed."
}

setup() {
    echo "Cloning dotfiles project..."

    command_exists git || {
        echo "Git is not installed."
        echo "Attempting to install Git..."
        install_git
    }
    
    git clone --depth=1 --branch ${BRANCH} ${REMOTE} ${DOTFILES} || {
        echo "git clone failed."
        exit 1
    }
}

bootstrap() {
    "${DOTFILES}/bootstrap.sh"
}

main() {
    setup
    bootstrap
}

main "$@"

