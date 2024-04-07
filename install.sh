#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  rm ~/.bashrc
  sudo apt update
  sudo apt-get install -y rcm tmux universal-ctags wget fuse
  rcup -f -v -d . -t development -t github

  # Use RDM for copy/paste and open support
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.3/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  chmod +x /usr/local/bin/rdm
  gh config set browser "rdm open"

  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  brew install neovim tree-sitter

elif [[ "$(uname)" = "Darwin" ]]; then
  brew install rcm
  rcup -v -d . -t macos -t development -t gpg
  rcup -v

else
  >&2 echo "error: Unknown system"
  exit 1
fi

if command -v go &>/dev/null; then
  go install github.com/nametake/golangci-lint-langserver@latest
else
  echo "Could not install golangci-lint-langserver. Go is not installed or not in PATH."
fi

if [[ "$CODESPACES" = "true" ]]; then
  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:
fi
