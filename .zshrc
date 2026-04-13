# Homebrew environment for interactive shells that do not read .zprofile.
if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"

if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
  fpath=("${BREW_PREFIX}/share/zsh/site-functions" $fpath)

  if [ -r "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  if [ -r "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME=""
  plugins=(git)
  source "$ZSH/oh-my-zsh.sh"
fi

alias home='cd ~ && eza -lh'
alias desk='cd ~/Desktop && eza -lh'
alias finder='open .'
alias chrome='open -a "Google Chrome"'
alias zed='vim ~/.zshrc'

alias ll='eza -lah --icons'
alias la='eza -a --icons'

# Securely store a key in macOS Keychain
key() {
    if [ -z "$1" ]; then
        echo "Usage: key <service_name>"
        return 1
    fi

    local service_name=$1
    local api_key

    printf "Enter key for %s: " "$service_name"
    read -rs api_key
    echo

    if [ -z "$api_key" ]; then
        echo "Key cannot be empty."
        return 1
    fi

    security add-generic-password -a "$USER" -s "$service_name" -w "$api_key" -U
    if [ $? -eq 0 ]; then
        echo "Key added successfully for service: $service_name"
    else
        echo "Failed to add key."
        return 1
    fi
}

# Retrieve a key from macOS Keychain
getkey() {
    if [ -z "$1" ]; then
        echo "Usage: getkey <service_name>"
        return 1
    fi

    local service_name=$1
    local api_key

    api_key=$(security find-generic-password -a "$USER" -s "$service_name" -w 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo "$api_key"
    else
        echo "No key found for service: $service_name"
        return 1
    fi
}

# opencode
export PATH=/Users/swappysh/.opencode/bin:$PATH
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
eval "$(direnv hook zsh)"
