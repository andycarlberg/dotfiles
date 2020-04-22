#!/bin/sh

# File
# Install script for fzf module
#
# Installs fzfg configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

bootstrap() {
  symlink "${DOTFILES}/modules/fzf/.fzf.zsh" "${HOME}"
}

main() {
  bootstrap
}

main "$@"
