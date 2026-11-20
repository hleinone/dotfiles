# Load aliases.
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# Colors
export CLICOLOR=1
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

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


# These initialize the completion system, providing the case-sensitive expansion
if type brew &>/dev/null; then
  FPATH="${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh-completions:$FPATH"

  autoload -Uz compinit
  if [[ ! -f ~/.zcompdump || -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -d ~/.zcompdump
    touch ~/.zcompdump
  else
    compinit -C -d ~/.zcompdump
  fi
fi

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

  # generate the init script from plugins above
  zgenom save
fi


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
  mas upgrade                   # Programmatic App Store update
  mise upgrade                  # Upgrade tools installed with mise

  # Upgrading gpg needs a restart, so let's do one just in case
  gpgconf --kill all
}

eval "$(starship init zsh)"
eval "$(mise activate zsh)"


