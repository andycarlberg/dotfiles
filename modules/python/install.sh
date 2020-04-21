#!/bin/sh

# File
# Install script for python module
#
# Installs pythong configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

install_pyenv() {
  install "git"
  git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
}

install_pyenv_virtualenv() {
  install "git"
  git clone https://github.com/pyenv/pyenv-virtualenv.git "${HOME}/.pyenv/plugins/pyenv-virtualenv"
}

setup() {
  install "python3"
  install_pyenv
  install_pyenv_virtualenv
}

bootstrap() {
  echo "No bootstrap required."
}

main() {
  setup
  bootstrap
}

main "$@"
