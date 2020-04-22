#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

bootstrap() {
  symlink "${DOTFILES}/modules/zsh/.zshrc" "${HOME}"
}

main() {
  bootstrap
}

main "$@"
