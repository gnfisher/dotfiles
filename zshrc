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

# export FZF_DEFAULT_OPTS='
#  --color=fg:#6b6b6b,bg:#ffffff,hl:#38fff2
#  --color=fg+:#000000,bg+:#ededed,hl+:#5fd7ff
#  --color=info:#7df087,prompt:#d7005f,pointer:#ac00eb
#  --color=marker:#36db04,spinner:#af5fff,header:#87afaf
# '

HOMEBREW_NO_AUTO_UPDATE=1

export PATH=$PATH:/usr/bin:/Users/greg/bin
export EDITOR=nvim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
export PATH="/usr/local/opt/scala@2.12/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
  ## Solarized Light color scheme for fzf
  #export FZF_DEFAULT_OPTS="
  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
  #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  #"
}
_gen_fzf_default_opts

alias vim=nvim
alias g=git
alias c=clear
alias scratch='nvim ~/Scratch'

alias sf='~/Code/ADS/ads-quoting-server/bin/salesforce'
alias sfq='~/Code/ADS/ads-quoting-server/bin/salesforce query '
alias sfd='~/Code/ADS/ads-quoting-server/bin/salesforce describe ' 
alias psad='psql ads_quoting_development'
