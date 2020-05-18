#!/bin/sh

# File
# Install script for tmux module
#
# Installs tmux configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

bootstrap() {
  mkdir -p "${HOME}/.config/alacritty"
  symlink "${DOTFILES}/modules/alacritty/alacritty.yml" "${HOME}/.config/alacritty"
}

main() {
  bootstrap
}

main "$@"
