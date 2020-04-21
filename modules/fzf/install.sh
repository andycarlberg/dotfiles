#!/bin/sh

# File
# Install script for fzf module
#
# Installs fzfg configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

install_fzf() {
  install "git"
  git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
}

setup() {
  install_fzf
}

bootstrap() {
  symlink "${DOTFILES}/modules/fzf/.fzf.zsh" "${HOME}"
}

main() {
  setup
  bootstrap
}

main "$@"
