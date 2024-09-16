for path in (ls -a ~/.config/fish/config.fish.*);
    source $path
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"

fish_config theme choose "dracula"
fish_config prompt choose "arrow"
