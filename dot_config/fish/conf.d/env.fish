# Environment setup (Variables and Paths)
# Set fisher_path to isolate fisher plugins
set fisher_path $__fish_config_dir/fisher

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# Native path management from chezmoi data
{{ range .paths -}}
fish_add_path "$HOME/{{ . }}"
{{ end -}}

# Tools that aren't in the packages list but need pathing
[ -d "$HOME/.lando/bin" ]; and fish_add_path "$HOME/.lando/bin"
[ -d "$HOME/.rd/bin" ]; and fish_add_path "$HOME/.rd/bin"
[ -d "$HOME/.local/bin" ]; and fish_add_path "$HOME/.local/bin"

# Enable homebrew if installed
if [ -d /home/linuxbrew/.linuxbrew ]
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else if [ -d ~/.linuxbrew ]
    eval "$(~/.linuxbrew/bin/brew shellenv)"
else if [ -d /opt/homebrew ]
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

# Activate mise (managed tool versions)
if type -q mise
    mise activate fish | source
end

# Preferred programs
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# Language
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Allow local overrides
if [ -e $__fish_config_dir/local.fish ]
    source $__fish_config_dir/local.fish
end
