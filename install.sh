#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

if [[ "$CODESPACES" = "true" ]]; then
  sudo apt update
  sudo apt-get install -y rcm wget
  rcup -f -v -d . -t development -t github

  # Use RDM for copy/paste and open support
  # wget https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.3/rdm-linux-amd64
  # sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  # chmod +x /usr/local/bin/rdm
  # gh config set browser "rdm open"

elif [[ "$(uname)" = "Darwin" ]]; then
  brew install rcm
  rcup -v -d . -t macos -t development -t gpg
else
  >&2 echo "error: Unknown system"
  exit 1
fi

if [[ "$CODESPACES" = "true" ]]; then
  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:
fi
