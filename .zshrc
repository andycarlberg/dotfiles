########################################
# Update dotfiles
########################################
yadm_is_current=$(yadm fetch --dry-run 2>&1)
[ -z $yadm_is_current ] || {
  yadm fetch origin
  yadm pull --rebase
  yadm_encrypt_is_current=$(yadm diff HEAD~1 HEAD | grep "files.gpg" 2>&1)
  [ -z $yadm_encrypt_is_current ] || {
    yadm decrypt
  }
  yadm bootstrap
}

########################################
# Antigen configuration
########################################
source ${HOME}/antigen.zsh

antigen use oh-my-zsh

antigen bundle fzf
antigen bundle git
antigen bundle gitfast
antigen bundle thefuck
antigen bundle z

antigen theme af-magic

antigen apply

########################################
# load aliases
########################################
source $HOME/aliases.zsh

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

########################################
# fzf configuration
########################################
export FZF_BASE="${HOME}/.fzf"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# If silver searcher is installed, use it to find files
if type ag &> /dev/null; then
  export FZF_DEFAULT_COMMAND="ag --hidden -p ${DOTFILES}/modules/fzf/.fzf.ignore -f -g \"\""
  export FZF_CTRL_T_COMMAND="ag --hidden -p ${DOTFILES}/modules/fzf/.fzf.ignore -f -g \"\""
fi

# Fix alt-c command on macOS
bindkey "ç" fzf-cd-widget

# Source fzf generated configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########################################
# pyenv configuration
########################################
if type pyenv &> /dev/null; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${HOME}/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

########################################
# thefuck configuration
########################################
if type thefuck &> /dev/null; then
  eval $(thefuck --alias)
fi

########################################
# Acquia BLT configuration
########################################
function blt() {
  if [[ ! -z ${AH_SITE_ENVIRONMENT} ]]; then
    PROJECT_ROOT="/var/www/html/${AH_SITE_GROUP}.${AH_SITE_ENVIRONMENT}"
  elif [ "$(git rev-parse --show-cdup 2> /dev/null)" != "" ]; then
    PROJECT_ROOT=$(git rev-parse --show-cdup)
  else
    PROJECT_ROOT="."
  fi

  if [ -f "$PROJECT_ROOT/vendor/bin/blt" ]; then
    $PROJECT_ROOT/vendor/bin/blt "$@"

  # Check for local BLT.
  elif [ -f "./vendor/bin/blt" ]; then
    ./vendor/bin/blt "$@"

  else
    echo "You must run this command from within a BLT-generated project."
    return 1
  fi
}

########################################
# sdkman configuration
########################################
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/andycarlberg/.sdkman"
[[ -s "/home/andycarlberg/.sdkman/bin/sdkman-init.sh" ]] && source "/home/andycarlberg/.sdkman/bin/sdkman-init.sh"

########################################
# Include Local configuration overrides
########################################
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local


