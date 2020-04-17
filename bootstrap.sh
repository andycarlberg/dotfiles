#!/bin/sh

# File
# Bootstrap script for Andy Carlberg's dotfiles.
# 
# Iterates through modules stored in the modules directory and runs their 
# install scripts. This configures a reproducible profile across multiple 
# machines.

# Defaults
export DOTFILES=${DOTFILES:-"$(dirname "$0")"}

# Find modules and run each install script.
for module in $( ls -A ${DOTFILES}/modules) ; do
    /bin/sh "${DOTFILES}/modules/${module}/install.sh"
done
