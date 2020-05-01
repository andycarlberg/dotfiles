########################################
# neovim configuration
########################################
export EDITOR="nvim"

# If we are running in a WSL instance
# Set the DISPLAY variable to trick neovim into thinking there is an X env
# and add the xsel script to the path.
# This is used to support copy-paste and things that depend on it
[ -z "${WSL_DISTRO_NAME}" ] || {
  export DISPLAY=${DISPLAY:-:0}
}


