# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

lazy() {
  export PATH="$PATH:$HOME/.nodenv/shims:$HOME/.jenv/shims:$HOME/.rbenv/shims:$HOME/.pyenv/shims:$HOME/.goenv/shims"
  lazyload nodenv $(ls -1 $HOME/.nodenv/shims) -- 'eval "$(nodenv init -)"'
  lazyload jenv $(ls -1 $HOME/.jenv/shims) -- 'eval "$(jenv init -)"'
  lazyload rbenv $(ls -1 $HOME/.rbenv/shims) flutter xcodebuild -- 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)";eval "$(rbenv init -)"'
  lazyload pyenv $(ls -1 $HOME/.pyenv/shims) brew -- 'eval "$(pyenv init -)"'
  lazyload goenv $(ls -1 $HOME/.goenv/shims) -- 'eval "$(goenv init -)"'
}

eager() {
  eval "$(nodenv init -)"
  eval "$(jenv init -)"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)";eval "$(rbenv init -)"
  eval "$(pyenv init -)"
  eval "$(goenv init -)"
}

# Colors
export CLICOLOR=1
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

export LANG=en_US.UTF-8
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export JAVA_HOME=""
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# History
setopt appendhistory sharehistory incappendhistory

autoload -Uz history-search-end
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[1;3C" forward-word # ⌥+→
bindkey "^[[1;3D" backward-word # ⌥+←
bindkey "^[[H" beginning-of-line # ⌘+←
bindkey "^[[F" end-of-line # ⌘+→
bindkey "^[[U" backward-kill-line # ⌘+␈
bindkey "^[^M" self-insert-unmeta
bindkey "^R" history-incremental-search-backward
bindkey "^[[R~" history-incremental-search-forward
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[[3~" delete-char # ␡
bindkey "3~" kill-word # ⌥+␡
bindkey "^[[A" up-line-or-beginning-search # ↑
bindkey "^[[B" down-line-or-beginning-search # ↓


# These two initialize the completion system,
# providing the case-sensitive expansion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
#autoload -Uz compinit
#compinit

# This sets the case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# load zgenom
source "$HOME/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom load qoomon/zsh-lazyload
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load gradle/gradle-completion

  # generate the init script from plugins above
  zgenom save
fi

PROCESS_NAME=$(ps -p $PPID -o comm=)
if [[ "${PROCESS_NAME[1]}" == "/" ]] then
  PARENT_PROCESS_NAME=$(basename "$PROCESS_NAME")
else
  PARENT_PROCESS_NAME="$PROCESS_NAME"
fi

echo "$PROCESS_NAME" >> "$HOME/.process_name"
echo "$PARENT_PROCESS_NAME" >> "$HOME/.parent_process_name"

# Lazy load nodenv jenv rbenv pyenv goenv
lazy

# Eager load if Visual Studio Code
if [[ "$PROCESS_NAME" == *"Visual Studio Code"* ]] then
  eager
fi

# Include Pub executables
export PATH="$HOME/.pub-cache/bin:$PATH"

# Include Mint executables
export PATH="$HOME/.mint/bin:$PATH"

# Include grep
export PATH="$HOMEBREW_PREFIX/var/homebrew/linked/grep/libexec/gnubin:$PATH"
# Include find
export PATH="$HOMEBREW_PREFIX/var/homebrew/linked/findutils/libexec/gnubin:$PATH"

# Load thefuck
lazyload fuck -- 'eval "$(thefuck --alias)"'

# timezsh
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# monday
monday() {
  # Upgrade everything
  brew cleanup                  # Remove old versions from the cellar
  brew upgrade                  # Upgrade most Homebrew packages
  #brew upgrade --cask --greedy  # Upgrade apps that have auto-update feature
  #softwareupdate -ia            # Mac's own software update
  mas upgrade                   # Programmatic App Store update

  # Upgrading gpg needs a restart, so let's do one just in case
  gpgconf --kill all

  >&2 echo "Installing latest Node globally using nodenv…"
  LATEST_NODE="$(nodenv install -l | ggrep -E '^[0-9\.]+$' | tail -1)"
  nodenv install -s "$LATEST_NODE"
  nodenv global "$LATEST_NODE"

  >&2 echo "Setting up latest Java globally using jenv…"
  for java in /Library/Java/JavaVirtualMachines/*; do
    jenv add "$java/Contents/Home/"
  done
  LATEST_JAVA="$(jenv versions --bare | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
  jenv global "$LATEST_JAVA"

  >&2 echo "Installing latest Ruby globally using rbenv…"
  LATEST_RUBY="$(rbenv install -L | ggrep -E '^[0-9\.]+$' | tail -1)"
  rbenv install -s "$LATEST_RUBY"
  rbenv global "$LATEST_RUBY"

  >&2 echo "Installing latest Python globally using pyenv…"
  LATEST_PYTHON="$(pyenv install -l | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
  pyenv install -s "$LATEST_PYTHON"
  pyenv global "$LATEST_PYTHON"

  >&2 echo "Installing latest Go globally using goenv…"
  LATEST_GO="$(goenv install -l | sed 's/^ *//g' | ggrep -E '^[0-9\.]+$' | tail -1)"
  goenv install -s "$LATEST_GO"
  goenv global "$LATEST_GO"
}

eval "$(starship init zsh)"
