{
  home.file."./.zshrc-personal".text = ''
    # Options
    setopt autocd
    setopt correct
    setopt extendedglob
    setopt nocaseglob
    setopt rcexpandparam
    setopt nocheckjobs
    setopt numericglobsort
    setopt nobeep
    setopt appendhistory
    setopt histignorealldups
    setopt inc_append_history
    setopt histignorespace

    # zstyle
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
    zstyle ':completion:*' rehash true
    zstyle ':completion:*' menu select
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache

    # Binds
    bindkey '^[[3~' delete-char
    bindkey '^[[C'  forward-char
    bindkey '^[[D'  backward-char
    bindkey '^[[5~' history-beginning-search-backward
    bindkey '^[[6~' history-beginning-search-forward
    bindkey '^[Oc' forward-word
    bindkey '^[Od' backward-word
    bindkey '^[[1;5D' backward-word
    bindkey '^[[1;5C' forward-word
    bindkey '^H' backward-kill-word
    bindkey '^[[Z' undo
  '';
}

