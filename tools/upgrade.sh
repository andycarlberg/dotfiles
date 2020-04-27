#!/bin/sh

# File upgrade.sh
# Upgrade the dotfiles automatically.
cd $DOTFILES

git pull --rebase --stat origin master
