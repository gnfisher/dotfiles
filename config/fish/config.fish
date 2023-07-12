if command -v starship >/dev/null
    starship init fish | source
end

for path in (ls -a ~/.config/fish/config.fish.*);
    source $path
end
