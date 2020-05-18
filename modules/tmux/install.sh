#!/bin/sh

# File
# Install script for tmux module
#
# Installs tmux configuration dotfiles.

# Include utility library
# shellcheck source=lib/util.sh
. "${DOTFILES}/lib/util.sh"

bootstrap() {
  symlink "${DOTFILES}/modules/tmux/.tmux.conf" "${HOME}"
}

main() {
  bootstrap
}

main "$@"
