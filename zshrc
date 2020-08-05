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

source ~/zprompts/zprompts.plugin.zsh
autoload -Uz compinit promptinit
compinit
promptinit
prompt scala4
# End of lines added by compinstall


# Disable ctrl+s
stty -ixon

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_OPTS='
#  --color=fg:#6b6b6b,bg:#ffffff,hl:#38fff2
#  --color=fg+:#000000,bg+:#ededed,hl+:#5fd7ff
#  --color=info:#7df087,prompt:#d7005f,pointer:#ac00eb
#  --color=marker:#36db04,spinner:#af5fff,header:#87afaf
# '

export PATH=$PATH:/usr/bin:/Users/greg/bin
export EDITOR=nvim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
export PATH="/usr/local/opt/scala@2.12/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

alias vim=nvim
alias g=git
alias c=clear
alias scratch='nvim ~/Scratch'

alias sf='~/Code/ADS/ads-quoting-server/bin/salesforce'
alias sfq='~/Code/ADS/ads-quoting-server/bin/salesforce query '
alias sfd='~/Code/ADS/ads-quoting-server/bin/salesforce describe ' 
alias psad='psql ads_quoting_development'
