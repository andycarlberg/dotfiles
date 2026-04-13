function posix_source
    if not test -r "$argv[1]"
        return
    end

    while read -l line
        # Skip empty lines and comments
        if string match -q "" (string trim $line); or string match -q "#*" (string trim $line)
            continue
        end

        # Handle exports (export KEY="value")
        if string match -qr "^export\s+(?<key>[A-Z0-9_]+)=(?<value>.*)" $line
            # Remove optional surrounding quotes
            set -l clean_value (string replace -ra '^["\']|["\']$' '' $value)
            set -gx $key $clean_value
        
        # Handle simple aliases (alias name='value')
        else if string match -qr "^alias\s+(?<name>[a-z0-9_-]+)=(?<value>.*)" $line
            # Remove optional surrounding quotes
            set -l clean_value (string replace -ra '^["\']|["\']$' '' $value)
            alias $name $clean_value
        end
    end < $argv[1]
end
