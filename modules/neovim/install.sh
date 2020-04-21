#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

setup() {
  install "neovim" "nvim"
}

bootstrap() {
  mkdir -p "${HOME}/.config/nvim"
  symlink "${DOTFILES}/modules/neovim/init.vim" "${HOME}/.config/nvim"
  symlink "${DOTFILES}/modules/neovim/coc-settings.json" "${HOME}/.config/nvim"
  nvim +"PlugInstall --sync" +qa
}

main() {
  setup
  bootstrap
}

main "$@"
