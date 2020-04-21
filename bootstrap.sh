#!/bin/sh

# File
# Bootstrap script for Andy Carlberg's dotfiles.
# 
# Iterates through modules stored in the modules directory and runs their 
# install scripts. This configures a reproducible profile across multiple 
# machines.

# Defaults
# Note: this will only be correct *most* of the time. It's covering the 80%, 
# not the 20%. See https://stackoverflow.com/a/29835459
export DOTFILES=${DOTFILES:-"$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"}

# Find modules and run each install script.
for module in $( ls -A ${DOTFILES}/modules) ; do
    /bin/sh "${DOTFILES}/modules/${module}/install.sh"
done
