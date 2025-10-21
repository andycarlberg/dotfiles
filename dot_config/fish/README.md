# Fish

The fish-shell uses a different syntax and is not POSIX-compliant. This means the nested shell dotfiles used for sh, bash, and zsh will not work for re-use in fish. For this reason, the fish configuration is entirely separate from the other shell configurations. Any desired functionality must be re-created in the fish configuration instead of re-used directly. However, an effort was made to use the same filename conventions to indicate under what circumstances configuration is loaded.
