if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
eval "$(mise activate zsh --shims)"
# Ensure that Xcode build system uses same environment as the shell
defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO
