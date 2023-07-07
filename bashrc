export PATH="$HOME/.bin:$PATH"

short_codespace_name="$(echo "$CODESPACE_NAME" | sed -Ee 's/^gnfisher-(.+)-[^-]+$/\1/')"
export PS1="\[\033[00;33m\]${short_codespace_name:-\h} \[\033[00;36m\]\W\[\033[31m\]\$ \[\033[0m\]"

export EDITOR=vim
export VISUAL=vim

alias psg="ps auxwww | head -n 1 ; ps auxwww | grep -Ei"
alias ll="ls -l"

export HISTSIZE=10000
export HISTFILESIZE=10000
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad

export GPG_TTY=$(tty)

for path in $(ls -a ~/.bashrc.*); do
  source $path
done

if [ -d "$HOME/.asdf" ]; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
. "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"
fi
