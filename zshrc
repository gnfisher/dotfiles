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

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#eeeeee,bg:#404040,hl:#afffff --color=fg+:#d0d0d0,bg+:#303030,hl+:#5fd7ff --color=info:#d7ffaf,prompt:#5fd7ff,pointer:#afffff --color=marker:#ffffd7,spinner:#afffff,header:#afffd7'

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH=$PATH:/usr/bin:/Users/greg/bin
export EDITOR=nvim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
export PATH="/usr/local/opt/scala@2.12/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export BAT_THEME="base16"

alias vim=nvim
alias vimrc=vim ~/.vimrc
alias g=git
alias c=clear
alias scratch='nvim ~/Scratch'

alias sf='~/Code/ADS/ads-quoting-server/bin/salesforce'
alias sfq='~/Code/ADS/ads-quoting-server/bin/salesforce query '
alias sfd='~/Code/ADS/ads-quoting-server/bin/salesforce describe ' 
alias psad='psql ads_quoting_development'
