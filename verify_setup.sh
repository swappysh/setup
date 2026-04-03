#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
failures=0

ok() {
  printf '✓ %s\n' "$*"
}

warn() {
  printf 'warning: %s\n' "$*" >&2
}

check_command() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    ok "$name is available: $(command -v "$name")"
  else
    warn "$name is missing"
    failures=$((failures + 1))
  fi
}

check_link() {
  local path="$1"
  local expected="$2"

  if [ -L "$path" ] && [ "$(readlink "$path")" = "$expected" ]; then
    ok "$path links to repo copy"
  else
    warn "$path is missing or not linked to $expected"
    failures=$((failures + 1))
  fi
}

check_file() {
  local path="$1"
  local label="$2"

  if [ -e "$path" ]; then
    ok "$label exists"
  else
    warn "$label is missing: $path"
    failures=$((failures + 1))
  fi
}

echo "Auth and setup verification"
echo

check_file "$repo_root/auth_ergonomics.sh" "Auth ergonomics helper"
if [ -x "$repo_root/auth_ergonomics.sh" ]; then
  ok "auth_ergonomics.sh is executable"
else
  warn "auth_ergonomics.sh is not executable"
  failures=$((failures + 1))
fi

check_command brew
check_command codex
check_command nvim

check_link "$HOME/.wezterm.lua" "$repo_root/.wezterm.lua"

check_link "$HOME/.config/nvim" "$repo_root/nvim"
check_file "$HOME/.config/nvim/init.lua" "Neovim init.lua"

ghostty_config="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
check_link "$ghostty_config" "$repo_root/ghostty/config.ghostty"

ssh_config="$HOME/.ssh/config"
check_link "$ssh_config" "$repo_root/ssh/config"

if [ -f "$ssh_config" ]; then
  if grep -qE 'UseKeychain[[:space:]]+yes' "$ssh_config"; then
    ok "SSH config includes Keychain-backed passphrase handling"
  else
    warn "SSH config does not advertise UseKeychain yes"
  fi
fi

if [ -r /etc/pam.d/sudo_local ] && grep -q 'pam_tid\.so' /etc/pam.d/sudo_local; then
  ok "Touch ID sudo helper is configured"
else
  warn "Touch ID sudo helper is not configured; follow the manual macOS sudo_local step"
fi

echo
echo "GitHub SSH test:"
echo "  ssh -T git@github.com"
echo "  If needed, create a key with:"
echo "    ssh-keygen -t ed25519 -C \"you@example.com\""
echo "  Then add the public key to GitHub and rerun the test."

echo
if [ "$failures" -eq 0 ]; then
  ok "verification passed"
  exit 0
fi

warn "verification finished with ${failures} issue(s)"
exit 1
