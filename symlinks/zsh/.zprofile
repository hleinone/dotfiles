if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="$HOME/.local/share/mise/shims:$PATH"
# Ensure that Xcode build system uses same environment as the shell
defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO
