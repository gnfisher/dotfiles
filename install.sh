#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  sudo apt update
  sudo apt-get install -y rcm tmux universal-ctags wget fuse
  rcup -f -v -d . -t development -t github

  # Use RDM for copy/paste and open support
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.3/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  chmod +x /usr/local/bin/rdm
  gh config set browser "rdm open"

else
  >&2 echo "error: Unknown system"
  exit 1
fi

# Git URL configuration
if [[ "$CODESPACES" = "true" ]]; then
    # Use HTTPS for GitHub in Codespaces
    git config --global url.https://github.com/.insteadOf git@github.com:
else
    # Use SSH everywhere else
    git config --global url.git@github.com:.insteadOf https://github.com/
fi
