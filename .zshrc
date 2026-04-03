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

# Shell aliases carried over from the old bash setup.
if [ -x /opt/homebrew/bin/nano ]; then
  alias nano='/opt/homebrew/bin/nano'
elif [ -x /usr/local/bin/nano ]; then
  alias nano='/usr/local/bin/nano'
fi

alias home='cd ~ && eza -lh'
alias desk='cd ~/Desktop && eza -lh'
alias finder='open .'
alias chrome='open -a "Google Chrome"'
alias zed='nano ~/.zshrc'

alias gs='git status --short --branch'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph --max-count=20'
alias ll='eza -lah --icons'
alias la='eza -a --icons'
