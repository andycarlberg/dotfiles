#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

# Include utility library
echo ${DOTFILES}

# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

install_zsh() {
  echo "Attempting to install Zsh..."
  sudo apt install zsh || {
    echo "Zsh install failed. Install Zsh manually."
  }
  echo "Zsh successfully installed."

  echo "Setting Zsh as default shell..."
  chsh -s "$(which zsh)" || {
    echo "Unable to set Zsh as default shell."
  }
  echo "Zsh successfully set as default shell."
}

install_ohmyzsh() {
  command_exists git || {
    echo "Git is not installed."
    install_git
  }

  echo "Attempting to install Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

setup() {
  command_exists zsh || {
    echo "Zsh is not installed."
    install_zsh
  }
  install_ohmyzsh
}

bootstrap() {
  ln -bsv "${DOTFILES}/modules/zsh/.zshrc" "${HOME}"
}

main() {
  setup
  bootstrap
}

main "$@"
