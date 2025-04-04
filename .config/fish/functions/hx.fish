# Handle helix editor name collision
function hx
    if command -q helix
        helix $argv
    else
        hx $argv
    end
end
