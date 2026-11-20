
# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Personal executable directories
# Prevent duplicate PATH entries
typeset -U PATH path

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/.mint/bin"
  "$HOME/.antigravity/antigravity/bin"
  $path
  /usr/local/bin
  /usr/local/sbin
)

# Rustup, after Homebrew
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# GNU tools
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  for d in "$HOMEBREW_PREFIX"/opt/*/libexec/gnubin(N); do
    [[ -d "$d" ]] && path=("$d" $path)
  done

  for d in "$HOMEBREW_PREFIX"/opt/*/libexec/gnuman(N); do
    [[ -d "$d" ]] && MANPATH="$d:${MANPATH-}"
  done
  export MANPATH
fi

# Development environment
export LANG=en_US.UTF-8
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Make mise tools available to login shells
eval "$(mise activate zsh --shims)"
