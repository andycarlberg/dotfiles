#!/bin/sh

# File
# Install script for neovim module
#
# Installs neovim configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

bootstrap() {
  mkdir -p "${HOME}/.config/nvim"
  symlink "${DOTFILES}/modules/neovim/init.vim" "${HOME}/.config/nvim"
  symlink "${DOTFILES}/modules/neovim/coc-settings.json" "${HOME}/.config/nvim"
}

main() {
  bootstrap
}

main "$@"
