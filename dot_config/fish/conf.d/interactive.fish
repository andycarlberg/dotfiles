if status is-interactive

    # Auto-attach to (or create) a Zellij session when opening a terminal
    # Run `touch ~/.no_zellij` to disable; `rm ~/.no_zellij` to re-enable
    if not test -e ~/.no_zellij; and type -q zellij; and not set -q ZELLIJ
        sleep 0.1
        zellij
    end

    # Source POSIX-compliant aliases and functions
    if type -q posix_source
        posix_source ~/.shell/interactive_aliases
    end

    if type -q starship
        starship init fish | source
    end

    if type -q fzf
        fzf --fish | source
    end

    # Enable vi mode
    fish_vi_key_bindings

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

end
