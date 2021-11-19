eval "$(starship init zsh)"

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

bindkey "^[[1;3C" forward-word # ⌥+→
bindkey "^[[1;3D" backward-word # ⌥+←
bindkey "^[[H" beginning-of-line # ⌘+←
bindkey "^[[F" end-of-line # ⌘+→
bindkey "^[[U" backward-kill-line # ⌘+␈
bindkey "^[^M" self-insert-unmeta
bindkey "^R" history-incremental-search-backward
bindkey "^[[R~" history-incremental-search-forward
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[[3~" delete-char # ␡
bindkey "3~" kill-word # ⌥+␡

# These two initialize the completion system,
# providing the case-sensitive expansion
autoload -Uz compinit
compinit

# This sets the case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen load qoomon/zsh-lazyload

  # generate the init script from plugins above
  zgen save
fi

# Load nodenv
lazyload nodenv $(ls -1 $HOME/.nodenv/shims) -- 'eval "$(nodenv init -)"'

# Load jenv
lazyload jenv $(ls -1 $HOME/.jenv/shims) -- 'export PATH="$HOME/.jenv/bin:$PATH";eval "$(jenv init -)"'

# Load rbenv
lazyload rbenv $(ls -1 $HOME/.rbenv/shims) flutter -- 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)";eval "$(rbenv init -)"'
# Eager load if Android Studio
PARENT_PROCESS_NAME=$(basename "$(ps -p $PPID -o comm=)")
if [[ "$PARENT_PROCESS_NAME" == "studio" ]] then
  rbenv
fi

# Load pyenv
lazyload pyenv $(ls -1 $HOME/.pyenv/shims) -- 'export PATH="$HOME/.pyenv/bin:$PATH";eval "$(pyenv init -)"'
alias brew="env PATH="${PATH//$HOME\/.pyenv\/shims:/}" brew"

# Include mysql-client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Load thefuck
lazyload fuck -- 'eval "$(thefuck --alias)"'

# timezsh
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
