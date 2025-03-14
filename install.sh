#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  rcup -f -v -d . -t development -t github

elif [[ "$(uname)" = "Darwin" ]]; then
  brew install rcm
  rcup -v -d . -t macos -t development -t gpg
  rcup -v

else
  >&2 echo "error: Unknown system"
  exit 1
fi

if [[ "$CODESPACES" = "true" ]]; then
  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:
fi
