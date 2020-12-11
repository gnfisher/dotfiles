# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/greg/.zshrc'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

fpath=(${HOME}/.asdf/completions $fpath)
source ~/zprompts/zprompts.plugin.zsh
autoload -Uz compinit promptinit
compinit
promptinit
prompt scala4
# End of lines added by compinstall


# Disable ctrl+s
stty -ixon

. $HOME/.asdf/asdf.sh

# . $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Gruvbox Dark
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

# Lucius Dark
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#eeeeee,bg:#404040,hl:#afffff --color=fg+:#d0d0d0,bg+:#303030,hl+:#5fd7ff --color=info:#d7ffaf,prompt:#5fd7ff,pointer:#afffff --color=marker:#ffffd7,spinner:#afffff,header:#afffd7'

# Mac Light
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#8a8a8a,bg:#ffffff,hl:#0072f5 --color=fg+:#000000,bg+:#ffffff,hl+:#0034e0 --color=info:#80db69,prompt:#ff0000,pointer:#af5fff --color=marker:#87ff00,spinner:#299900,header:#080808'

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH=$PATH:/usr/bin:/Users/greg/bin:/Applications
export EDITOR=nvim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
# export PATH="/usr/local/opt/scala@2.12/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Users/greg/Library/Application Support/Coursier/bin"
export BAT_THEME="base16"

alias vim=nvim
alias vimrc='vim ~/.config/nvim'
alias g=git
alias c=clear

alias sf='~/Code/ADS/ads-quoting-server/bin/salesforce'
alias sfq='~/Code/ADS/ads-quoting-server/bin/salesforce query '
alias sfd='~/Code/ADS/ads-quoting-server/bin/salesforce describe ' 
alias psad='psql ads_quoting_development'
