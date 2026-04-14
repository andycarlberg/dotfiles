function _a --description "Create a persistent fish abbreviation"
    if test (count $argv) -lt 2
        echo "Usage: _a <name> <expansion>"
        return 1
    end
    abbr --add $argv[1] $argv[2..]
    saveabbrs
end
