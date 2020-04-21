# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

########################################
# Oh My Zsh configuration
########################################
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
# pyenv configuration
########################################
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

########################################
# neovim configuration
########################################
export EDITOR="nvim"

########################################
# fzf configuration
########################################
export FZF_BASE="/usr/local/bin/fzf"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -f -g \"\""

