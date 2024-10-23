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
compinit -D

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
export EDITOR=vi
setopt emacs

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

# Source asdf
source $(brew --prefix asdf)/libexec/asdf.sh

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
