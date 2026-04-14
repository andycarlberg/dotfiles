# Parse and apply simple `export` and `alias` lines from a POSIX shell file.
#
# Limitations (by design — this is a best-effort bridge):
#   - Only handles single-line `export KEY=value` and `alias name=value` forms.
#   - Variable references in values (e.g. export PATH="$HOME/bin:$PATH") are NOT
#     expanded; the literal string is used instead.
#   - Multi-line constructs, shell functions, conditionals, and `export A=1 B=2`
#     are silently skipped.
#   - Use this for simple alias/env sharing only. Complex logic belongs in
#     ~/.config/fish/conf.d/*.fish files instead.
function posix_source
    if not test -r "$argv[1]"
        return
    end

    while read -l line
        # Skip empty lines and comments
        if string match -q "" (string trim $line); or string match -q "#*" (string trim $line)
            continue
        end

        # Handle exports: export KEY=value  (keys may be upper or lowercase)
        if string match -qr "^export\s+(?<key>[A-Za-z_][A-Za-z0-9_]*)=(?<value>.*)" $line
            set -l clean_value (string replace -r "^(['\"])(.*)\1\$" '$2' $value)
            set -gx $key $clean_value

        # Handle simple aliases: alias name=value  (names may include hyphens)
        else if string match -qr "^alias\s+(?<name>[A-Za-z_][A-Za-z0-9_-]*)=(?<value>.*)" $line
            set -l clean_value (string replace -r "^(['\"])(.*)\1\$" '$2' $value)
            alias $name $clean_value
        end
    end < $argv[1]
end
