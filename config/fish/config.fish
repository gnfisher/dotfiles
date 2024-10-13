for path in (ls -a ~/.config/fish/config.fish.*);
    source $path
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"

fish_config prompt choose "arrow"

alias ??="~/bin/my-prompt"
source ~/.config/fish/config.fish
