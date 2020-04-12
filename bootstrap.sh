#!/bin/sh

# File
# Bootstrap script for Andy Carlberg's dotfiles
# 
# Iterates through modules stored in the modules directory, installs, and
# symlinks config files. This configures a reproducible profile across 
# multiple machines.

# Symlink each dotfile in the modules folder to the home folder
for file in $( ls -A ./modules) ; do
    ln -sv "${PWD}/modules/${file}" "${HOME}"
done
