# Set fisher_path to isolate fisher plugins
set fisher_path $__fish_config_dir/fisher

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# Install fisher if it doesn't exist
if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

# Enable homebrew if installed
if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

# Activate mise if installed
if type -q mise
    mise activate fish | source
end

set -gx EDITOR hx

# Allow local overrides
if [ -e $__fish_config_dir/local.fish ]
    source $__fish_config_dir/local.fish
end
