# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# Colors
export CLICOLOR=1
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

export LANG=en_US.UTF-8
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export JAVA_HOME=""
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# History
setopt appendhistory
setopt sharehistory
setopt incappendhistory

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

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

# Load nodenv
lazyload nodenv $(ls -1 $HOME/.nodenv/shims) -- 'eval "$(nodenv init -)"'

# Load jenv
lazyload jenv $(ls -1 $HOME/.jenv/shims) -- 'export PATH="$HOME/.jenv/bin:$PATH";eval "$(jenv init -)"'

# Load rbenv
lazyload rbenv $(ls -1 $HOME/.rbenv/shims) flutter -- 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)";eval "$(rbenv init -)"'

# Load pyenv
lazyload pyenv $(ls -1 $HOME/.pyenv/shims) brew -- 'export PATH="$HOME/.pyenv/bin:$PATH";eval "$(pyenv init -)"'

# Load goenv
lazyload goenv $(ls -1 $HOME/.goenv/shims) code -- 'eval "$(goenv init -)"'

# Eager load if VSCode
if [[ "$PROCESS_NAME" == *"Visual Studio Code"* ]] then
  >&2 echo "Eager load goenv & rbenv"
  eval 'eval "$(goenv init -)"'
  eval 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)";eval "$(rbenv init -)"'
fi

# Include mysql-client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Include Pub executables
export PATH="$HOME/.pub-cache/bin:$PATH"

# Load thefuck
lazyload fuck -- 'eval "$(thefuck --alias)"'

# timezsh
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

eval "$(starship init zsh)"
