########################################
# fzf configuration
########################################
export FZF_BASE="${HOME}/.fzf"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# If silver searcher is installed, use it to find files
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND="ag --hidden -p ${DOTFILES}/modules/fzf/.ignore -f -g \"\""
    export FZF_CTRL_T_COMMAND="ag --hidden -p ${DOTFILES}/modules/fzf/.ignore -f -g \"\""
fi

# Fix alt-c command on macOS
bindkey "ç" fzf-cd-widget

# Source fzf generated configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


