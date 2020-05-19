# OS-agnostic method to find canonical filepath
#
# This function is necessary because `readlink -f` is not available on macOS (though `readlink` is).
# It must be included here because it is used to locate the dotfiles project directory.
# TODO: Remove this when a more robust way of locating the directory is implemented.
canonical_filepath() {
  readlink -f $1 2> /dev/null || {
    TARGET=$1

    cd $(dirname "$TARGET")
    TARGET=$(basename "$TARGET")

    # Iterate down a (possible) chain of symlinks
    while [ -L "$TARGET" ]; do
      TARGET=$(readlink "$TARGET")
      cd $(dirname "$TARGET")
      TARGET=$(basename "$TARGET")
    done

    # Compute the canonicalized name by finding the physical path
    # for the directory we're in and appending the target file.
    DIR=$(pwd -P)
    RESULT="$DIR/$TARGET"

    echo $RESULT
  }
}

# Find the root of the dotfiles repository
# TODO: Find a more robust way to find the dotfiles path
# First find the canonical location of the .zshrc file
ZSHRC_PATH="$(canonical_filepath ${HOME}/.zshrc)"
# Second use dirname to move up three directories to the root of the dotfiles
#         3          2     1
# <dotfiles-root>/modules/zsh/.zshrc
export DOTFILES="$(dirname -- $(dirname -- $(dirname -- $ZSHRC_PATH)))"

# Check for dotfile updates
UPGRADE_RESULT=$(source ${DOTFILES}/tools/upgrade.sh)

# Add dotfiles scripts to path
export PATH=${DOTFILES}/bin:${PATH}

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

# include module shell configuration
for module in $(ls -A ${DOTFILES}/modules); do
  ZSH_CONFIG="${DOTFILES}/modules/${module}/config.zsh"
  [ -f $ZSH_CONFIG ] && source $ZSH_CONFIG
done

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
  elif [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
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

