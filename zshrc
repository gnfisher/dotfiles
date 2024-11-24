# Disable Ctrl-S and Ctrl-Q flow control
# `stty -ixon` disables XON/XOFF flow control at the terminal level
# `unsetopt flowcontrol` disables flow control at the shell level
stty -ixon
unsetopt flowcontrol

# Initialize prompt
autoload -Uz promptinit
promptinit
prompt redhat

# Initialize completion
autoload -Uz compinit
compinit -C

# Enable shift-tab to go backwards
bindkey '^[[Z' reverse-menu-complete

setopt append_history         # Append, not replace
setopt inc_append_history     # Immediately append history
setopt always_to_end          # Always go to end of line on complete
setopt correct                # Correct typos
setopt hist_ignore_dups       # Do not show dupes in history
setopt hist_ignore_space      # Ignore commands starting with space
setopt prompt_subst           # Necessary for pretty prompts

# Add PATH
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/.bin:$PATH"

# Add colors
alias ls='ls -G'
alias ll='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
bindkey '^xp' history-beginning-search-backward
bindkey '^xn' history-beginning-search-forward

# Use vim as the editor
export EDITOR=vim
setopt emacs

# Don't notify about running jobs
unsetopt notify

# Set grep options
alias grep='grep --color=auto --ignore-case'

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Aliases
function mkcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ }

# Add homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Source completions
source $HOME/.zsh/completions.zsh

# One tab to complete
setopt MENU_COMPLETE

# Go
export GOPROXY=https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB=github.com/github/*
export GOPATH=`go env GOPATH`
export PATH=$GOPATH/bin:$PATH

# If in VS Code, use code as the editor
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export EDITOR=vim
  export VISUAL="code --wait"
fi

# Load fzf if it is installed and exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden -g ""'
export FZF_DEFAULT_OPTS='--color=16'

# Source macOS specific configs
[[ "$OSTYPE" == "darwin"* ]] && source $HOME/.zsh/macos.zsh