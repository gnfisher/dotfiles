# Homebrew site functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Source asdf via Homebrew
source $(brew --prefix asdf)/libexec/asdf.sh