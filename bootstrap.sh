#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
timestamp="$(date +%Y%m%d%H%M%S)"

log() {
  printf '==> %s\n' "$*"
}

warn() {
  printf 'warning: %s\n' "$*" >&2
}

ensure_xcode_clt() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  log "Installing Xcode Command Line Tools"
  xcode-select --install || true
  warn "Finish the Command Line Tools install, then rerun bootstrap.sh."
  exit 1
}

ensure_brew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

ensure_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    return
  fi

  log "Installing Oh My Zsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
}

brew_shellenv() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

link_file() {
  src="$1"
  dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    current_target="$(readlink "$dest")"
    if [ "$current_target" = "$src" ]; then
      return
    fi
    rm "$dest"
  elif [ -e "$dest" ]; then
    backup="${dest}.backup-${timestamp}"
    log "Backing up $(basename "$dest") to $(basename "$backup")"
    mv "$dest" "$backup"
  fi

  ln -s "$src" "$dest"
}

ensure_xcode_clt
ensure_brew
brew_shellenv
ensure_oh_my_zsh

log "Installing Homebrew packages"
brew bundle --file "$repo_root/Brewfile"

log "Installing Codex"
if ! command -v codex >/dev/null 2>&1; then
  npm install -g @openai/codex
fi

log "Linking shell and terminal configs"
link_file "$repo_root/.zprofile" "$HOME/.zprofile"
link_file "$repo_root/.zshrc" "$HOME/.zshrc"
link_file "$repo_root/.gitconfig" "$HOME/.gitconfig"
link_file "$repo_root/ssh/config" "$HOME/.ssh/config"
link_file "$repo_root/.wezterm.lua" "$HOME/.wezterm.lua"
link_file "$repo_root/ghostty/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

log "Auth ergonomics check"
bash "$repo_root/auth_ergonomics.sh" || true

log "Done"
