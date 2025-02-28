if status is-interactive

    if type -q starship
        starship init fish | source
    end

    if type -q fzf
        # Set up fzf key bindings
        set -gx FZF_CTRL_R_OPTS "--layout reverse"
        fzf --fish | source
    end

end
