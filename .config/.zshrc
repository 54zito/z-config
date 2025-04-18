# ALIASES
alias ls='ls --color'
alias l='ls -la'
alias lr='ls -lR'
alias c='clear'
alias drs='darwin-rebuild switch --flake ~/z-config/nix#arya'

alias grep='grep --color'

# COMPLETION OPTIONS
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# KEY BINDINGS
bindkey '^n' history-search-backward
bindkey '^p' history-search-forward

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=5400
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# INTEGRATIONS
eval "$(zoxide init --cmd cd zsh)"
