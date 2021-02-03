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

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" backward-kill-line
bindkey "^[^M" self-insert-unmeta
bindkey "^R" history-incremental-search-backward
bindkey "^[[R~" history-incremental-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# These two initialize the completion system,
# providing the case-sensitive expansion
autoload -U compinit
compinit

# This sets the case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here

  # generate the init script from plugins above
  zgen save
fi

# Load nodenv
eval "$(nodenv init -)"

# Load jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Load rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"

# Load thefuck
eval "$(thefuck --alias)"

# timezsh
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
