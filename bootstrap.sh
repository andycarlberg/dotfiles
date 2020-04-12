#!/bin/sh

# File
# Bootstrap script for Andy Carlberg's dotfiles.
# 
# Iterates through modules stored in the modules directory and runs their 
# install scripts. This configures a reproducible profile across multiple 
# machines.

# Find modules and run each install script.
for module in $( ls -A ./modules) ; do
    /bin/sh "${PWD}/modules/${module}/install.sh"
done
