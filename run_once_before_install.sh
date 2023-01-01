#!/usr/bin/env bash

echo -e "\033[0;34mAdding  git-core apt repository...\033[0m"
sudo add-apt-repository ppa:git-core/ppa -y

echo -e "\033[0;34mUpdating and upgrading apt...\033[0m"
sudo apt update -y && sudo apt upgrade -y

echo -e "\033[0;34mInstalling apt packages...\033[0m"
sudo apt install git curl unzip zip python3-pip httpie -y

if ! command -v tailscale >/dev/null; then
  echo -e "\033[0;34mInstalling the Tailscale CLI...\033[0m"
  curl -fsSL https://tailscale.com/install.sh | sh
fi

if ! command -v gh >/dev/null; then
  echo -e "\033[0;34mInstalling the GitHub CLI...\033[0m"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  sudo apt update
  sudo apt install gh
fi

if ! command -v cargo >/dev/null; then
  echo -e "\033[0;34mInstalling Rust...\033[0m"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
fi

if ! command -v node >/dev/null; then
  echo -e "\033[0;34mInstalling NodeJS LTS...\033[0m"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  source $HOME/.nvm/nvm.sh
  nvm install --lts
  nvm install-latest-npm
fi

if ! command -v sdk >/dev/null; then
  echo -e "\033[0;34mInstalling java sdk 11.0.10...\033[0m"
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java
fi

if ! command -v starship >/dev/null; then
  echo -e "\033[0;34mInstalling starship...\033[0m"
  curl -sS https://starship.rs/install.sh | sh
  eval "$(starship init zsh)"
fi

if ! command -v bat >/dev/null; then
  echo -e "\033[0;34mInstalling Bat v0.22.1...\033[0m"
  curl -sLO https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-musl_0.22.1_amd64.deb
  sudo mv ./bat-*.deb tmp/
  sudo apt install -y tmp/bat-*.deb
fi

if ! command -v lsd >/dev/null; then
  echo -e "\033[0;34mInstalling LSD v0.23.1...\033[0m"
  curl -sLO https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo mv ./lsd_*.deb tmp/
  sudo apt install -y tmp/lsd_*.deb
fi
