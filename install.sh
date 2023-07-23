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

  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  brew install neovim starship typescript-language-server vscode-langservers-extracted golangci-lint

  if [[ -d /etc/ssh ]]; then
    echo 'AcceptEnv TZ LC_*' >> /etc/ssh/sshd_config
  fi
elif [[ "$(uname)" = "Darwin" ]]; then
  brew install rcm
  rcup -v -d . -t macos -t development -t gpg
  rcup -v
else
  >&2 echo "error: Unknown system"
  exit 1
fi

nvim -s --headless -c "PlugInstall | qa"
nvim -s --headless -c "TSUpdate | qa"

if [[ "$CODESPACES" = "true" ]]; then
  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:

  # Use fish
  sudo chsh -s $(which fish) $(whoami)
fi
