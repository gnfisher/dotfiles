for path in (ls -a ~/.config/fish/config.fish.*);
    source $path
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"
