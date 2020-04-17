#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

setup() {
  install "neovim"
}

bootstrap() {
  mkdir -p "${HOME}/.config/nvim"
  ln -bsv "${DOTFILES}/modules/neovim/init.vim" "${HOME}/.config/nvim"
  ln -bsv "${DOTFILES}/modules/neovim/coc-settings.json" "${HOME}/.config/nvim"
}

main() {
  setup
  bootstrap
}

main "$@"
