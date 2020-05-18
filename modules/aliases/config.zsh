create_alias() {
    # Capture the new alias
    NEW_ALIAS="${1}"
    # Remove the new alias from the arguments, leaving the command to be aliased
    # This removes the need for quotes aroung multi-part commands like "git add"
    shift

    alias "${NEW_ALIAS}"="$(echo ${@})"
    echo "alias ${NEW_ALIAS}=\"${@}\"" >> ${DOTFILES}/modules/aliases/config.zsh
}

_list_colors() {
    # https://superuser.com/questions/285381/how-does-the-tmux-color-palette-work
    if [ -z $1 ]; then
        BREAK=8
    else
        BREAK=$1
    fi
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i} \t"
        if [ $(( i % $BREAK )) -eq $(($BREAK-1)) ] ; then
            printf "\n"
        fi
    done
}

########################################
# Helpers 
########################################
alias _a=create_alias
alias colors=_list_colors

########################################
# Git
########################################
alias gcm="git commit -m"
alias gcan="git commit --amend --no-edit"
alias gwhere="git branch"
alias gwhat="git status"
alias ghow="git diff"
alias gwhen="git log"
alias gget="git checkout"
alias ggive="git push"
alias gadd="git add"
alias gall="git add ."
alias gsave="git commit"

########################################
# Uncategorized aliases
########################################
# These are aliases that have been quick-added but not organized. Generally,
# they should be organized before being commited to the dotfiles repo.

