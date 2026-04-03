#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() {
  printf '==> %s\n' "$*"
}

note() {
  printf '  - %s\n' "$*"
}

ssh_dir="$HOME/.ssh"
ssh_config="$ssh_dir/config"
repo_ssh_config="$repo_root/ssh/config"
git_email="$(git config --global user.email 2>/dev/null || true)"
key_comment="${git_email:-you@example.com}"

info "Touch ID for sudo"
note "macOS supports this, but the change is manual and privileged."
note "Create /etc/pam.d/sudo_local yourself and add: auth       sufficient     pam_tid.so"

info "SSH key"
private_key=""
if [ -d "$ssh_dir" ]; then
  private_key="$(find "$ssh_dir" -maxdepth 1 -type f -name 'id_*' ! -name '*.pub' 2>/dev/null | head -n 1 || true)"
fi

if [ -n "$private_key" ]; then
  note "Found an SSH private key: $private_key"
  note "If it is the key you use for GitHub, run: ssh-add --apple-use-keychain \"$private_key\""
else
  note "No SSH private key found in ~/.ssh."
  note "Create one with: ssh-keygen -t ed25519 -C \"$key_comment\""
fi

info "SSH client config"
if [ -L "$ssh_config" ] && [ "$(readlink "$ssh_config")" = "$repo_ssh_config" ]; then
  note "~/.ssh/config is linked to the repo copy."
elif [ -f "$ssh_config" ] && grep -q "UseKeychain yes" "$ssh_config" 2>/dev/null; then
  note "~/.ssh/config already mentions UseKeychain."
else
  note "Bootstrap should link $repo_ssh_config to ~/.ssh/config."
  note "If you are setting this up manually, keep AddKeysToAgent and UseKeychain enabled for github.com."
fi

info "GitHub verification"
if command -v gh >/dev/null 2>&1; then
  if gh auth status -h github.com >/dev/null 2>&1; then
    note "gh auth status passed."
  else
    note "gh auth status did not pass yet."
    note "Run: gh auth login -h github.com"
  fi
else
  note "gh is not installed yet."
fi

if [ -n "$private_key" ]; then
  if ssh -o BatchMode=yes -T git@github.com >/dev/null 2>&1; then
    note "ssh -T git@github.com succeeded."
  else
    note "ssh -T git@github.com did not succeed yet."
    note "After adding the key to GitHub, rerun: ssh -T git@github.com"
  fi
else
  note "Run ssh -T git@github.com after you generate and add a key."
fi
