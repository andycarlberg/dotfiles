#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

mkdir -p "${HOME}/.config/nvim"
ln -bsv "${PWD}/modules/neovim/init.vim" "${HOME}/.config/nvim"
ln -bsv "${PWD}/modules/neovim/coc-settings.json" "${HOME}/.config/nvim"
