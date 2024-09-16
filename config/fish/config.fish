for path in (ls -a ~/.config/fish/config.fish.*);
    source $path
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"

fish_config theme choose "base16 default dark"
fish_config prompt choose "arrow"
