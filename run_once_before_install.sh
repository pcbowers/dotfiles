#!/usr/bin/env bash

# The Total Number of Log Lines
TOTAL_LOG_LINES=12

# Window Size, Calculated By Available Space
WINDOW_SIZE=$(($(eval "tput lines") - TOTAL_LOG_LINES))

# Colors
NOCOLOR='\033[0m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
DARKGRAY='\033[1;30m'
YELLOW='\033[1;33m'

# Track Number of Logs
LOG_COUNT=0

# Create a scrolling window
create_window() {
  START=$((LOG_COUNT + 1))
  END=$((START + $1))

  # If the terminal is large enough, start the window
  if [[ "$START" -lt "$END" ]]; then
    echo -en $(eval "echo '\e[${START};${END}r\e[${START}H'")
  fi

  echo -en "${DARKGRAY}"
}

# End a scrolling window
end_window() {
  END=$((LOG_COUNT + 1))

  # If the terminal is large enough, end the window
  CHECK=$((0 + $1))
  if [[ "$CHECK" -gt 0 ]]; then
    # Clear the lines
    for ((i = 1; i <= $1; i++)); do
      echo ""
    done

    echo -en $(eval "echo '\e[r\e[${END}H'")
  fi

  echo -en "${NOCOLOR}"
}

# Begin a log
begin_log() {
  LOG_COUNT=$((LOG_COUNT + 1))
  echo -e "⏳ ${BLUE}$*${NOCOLOR}"
  create_window WINDOW_SIZE
}

# End a log
end_log() {
  end_window WINDOW_SIZE

  # If the terminal is large enough, overwrite the last line
  if [[ "$WINDOW_SIZE" -gt 0 ]]; then
    tput cuu 1
    echo -en "\033[2K"
  fi

  echo -e "✅ ${YELLOW}$*${NOCOLOR}"
}

# Print a single log
single_log() {
  LOG_COUNT=$((LOG_COUNT + 1))
  echo -e "⏭️ ${PURPLE}$*${NOCOLOR}"
}

# Clear the screen
clear -x

if ! grep -q "git-core" /etc/apt/sources.list.d/*; then
  begin_log "Adding git-core ppa repository..."
  sudo add-apt-repository ppa:git-core/ppa -y
  end_log "Added git-core ppa repository!"
else
  single_log "Already Added git-core apt repository"
fi

begin_log "Installing apt packages..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install git curl unzip zip zsh python3 python3-pip -y
end_log "Installed apt packages!"

if [ $SHELL != "$(which zsh)" ]; then
  begin_log "Setting ZSH as the default Shell..."
  chsh -s $(which zsh)
  end_log "ZSH set as the default shell!"
else
  single_log "ZSH already set as the default shell"
fi

if ! command -v tailscale >/dev/null; then
  begin_log "Installing the Tailscale CLI..."
  curl -fsSL https://tailscale.com/install.sh | sh
  end_log "Installed the Tailscale CLI!"
else
  single_log "Already installed the Tailscale CLI"
fi

if ! command -v gh >/dev/null; then
  begin_log "Installing the GitHub CLI..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  sudo apt update
  sudo apt install gh
  end_log "Installed the GitHub CLI!"
else
  single_log "Already installed the GitHub CLI"
fi

if ! command -v cargo >/dev/null; then
  begin_log "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  end_log "Installed Rust!"
else
  single_log "Already installed Rust"
fi

if ! command -v node >/dev/null; then
  begin_log "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  source $HOME/.nvm/nvm.sh
  nvm install --lts
  nvm install-latest-npm
  end_log "Installed NVM!"
else
  single_log "Already installed NVM"
fi

if [ ! -d "$HOME/.sdkman" ]; then
  begin_log "Installing SDK Man..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java
  end_log "Installed SDK Man!"
else
  single_log "Already installed SDK Man"
fi

if [ ! -d "$HOME/.antidote" ]; then
  begin_log "Installing Antidote (A ZSH Plugin Manager)..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git $HOME/.antidote
  end_log "Installed Antidote (A ZSH Plugin Manager)!"
else
  single_log "Already installed Antidote (A ZSH Plugin Manager)"
fi

if ! command -v starship >/dev/null; then
  begin_log "Installing Starship Prompt..."
  curl -sS https://starship.rs/install.sh | sh
  eval "$(starship init zsh)"
  end_log "Installed Starship Prompt!"
else
  single_log "Already installed Starship Prompt"
fi

if ! command -v bat >/dev/null; then
  begin_log "Installing Bat v0.22.1..."
  curl -sLO https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-musl_0.22.1_amd64.deb
  sudo mv ./bat-*.deb /tmp/
  sudo apt install -y /tmp/bat-*.deb
  end_log "Installed Bat!"
else
  single_log "Already installed Bat"
fi

if ! command -v lsd >/dev/null; then
  begin_log "Installing LSD v0.23.1..."
  curl -sLO https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo mv ./lsd_*.deb /tmp/
  sudo apt install -y /tmp/lsd_*.deb
  end_log "Installed LSD!"
else
  single_log "Already installed LSD"
fi

if [ $SHELL != "$(which zsh)" ]; then
  echo -e "${YELLOW}"
  echo "Make sure to close and re-open your terminal to begin using ZSH as your default Shell."
  echo -en "${NOCOLOR}"
fi

echo -e "${GREEN}"
echo "Package Installation Complete! Your terminal is ready to go!"
echo -en "${NOCOLOR}"
