#!/bin/sh

# File
# Install script for zsh module
#
# Installs zsh configuration dotfiles.

ln -sv "${PWD}/modules/zsh/.zshrc" "${HOME}"
