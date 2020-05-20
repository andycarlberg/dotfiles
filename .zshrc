########################################
# Load tmux on startup
########################################
command -v tmux > /dev/null 2>&1 && [ -z "$TMUX" ] && { tmux attach || exec tmux new-session -c "$PWD" && exit; }

########################################
# Oh My Zsh configuration
########################################

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="af-magic"

DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf git gitfast z)

source $ZSH/oh-my-zsh.sh

########################################
# load aliases
########################################
source $HOME/.zsh.aliases

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
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
# Include Local configuration overrides
########################################
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local
