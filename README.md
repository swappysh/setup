# Development Environment Setup

Fresh-mac bootstrap for this machine. It installs the base tooling, links the tracked dotfiles, and keeps both Ghostty and WezTerm supported.

## Quick Start

```bash
git clone git@github.com:swappysh/setup.git
cd setup
bash bootstrap.sh
```

If Xcode Command Line Tools are missing, the script will prompt for them and exit. Rerun `bootstrap.sh` after the install finishes.

## What Bootstrap Does

- Installs Homebrew packages from [Brewfile](./Brewfile): `git`, `gh`, `zsh`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `eza`, `bat`, and `node`
- Installs the terminal apps `Ghostty` and `WezTerm`
- Links the repo-managed dotfiles into your home directory:
  - [`.zprofile`](./.zprofile)
  - [`.zshrc`](./.zshrc)
  - [`.gitconfig`](./.gitconfig)
  - [`ssh/config`](./ssh/config) to `~/.ssh/config`
  - [`.wezterm.lua`](./.wezterm.lua)
  - [`ghostty/config.ghostty`](./ghostty/config.ghostty) to Ghostty's macOS config path
- Installs `@openai/codex` after Node is available
- Runs `auth_ergonomics.sh` so you can finish Touch ID, SSH, and GitHub auth setup with explicit prompts

Existing home files are backed up before being replaced.

## Shell Setup

[`./.zprofile`](./.zprofile) sets up Homebrew for login shells. [`./.zshrc`](./.zshrc) loads the autosuggestions and syntax-highlighting plugins and sets a few practical aliases.

If you want Homebrew `zsh` as your login shell, set it explicitly after bootstrap. The repo does not change your account shell for you.

## Terminal Setup

Both WezTerm and Ghostty are tracked in this repo and linked by bootstrap, so you can use either app on the new machine without redoing the setup work.

The current WezTerm config keeps the same basic preferences:

- MesloLGS Nerd Font Mono at size 19
- `tokyonight_night`
- opacity and blur enabled
- tab bar and pane navigation bindings
- `eza`/`bat` friendly shell setup

## SSH And GitHub

After bootstrap, verify your key and GitHub access:

```bash
ssh -T git@github.com
gh auth status -h github.com
```

If you still need a key, create one with `ssh-keygen -t ed25519 -C "you@example.com"`, add the public key to GitHub, and then run `ssh-add --apple-use-keychain ~/.ssh/id_ed25519` so passphrases stay in the macOS Keychain.

The repo ships a tracked SSH client config in [`ssh/config`](./ssh/config), and bootstrap links it to `~/.ssh/config` so `AddKeysToAgent yes` and `UseKeychain yes` are already in place.

## Sudo Touch ID

macOS can use Touch ID for `sudo`, but that requires a manual privileged change. Create `/etc/pam.d/sudo_local` yourself and add:

```text
auth       sufficient     pam_tid.so
```

The bootstrap script runs `auth_ergonomics.sh` to print this reminder, but it does not edit `/etc/pam.d` for you.

## Codex

`bootstrap.sh` installs `@openai/codex` after Node is present. If you skip bootstrap, install it manually with `npm install -g @openai/codex`.

## Verification

After bootstrap, run `bash verify_setup.sh` to confirm the expected auth and setup pieces are present.
