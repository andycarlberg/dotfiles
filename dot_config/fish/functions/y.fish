function y --wraps yazi --description "Open yazi and cd to the directory on exit"
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file=$tmp
    if set cwd (command cat -- $tmp); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- $cwd
    end
    rm -f -- $tmp
end
