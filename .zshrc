HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

autoload -Uz compinit
compinit -C

fpath+=($HOME/.zsh/pure)
autoload -Uz promptinit
promptinit
prompt pure

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable zoxide
eval "$(zoxide init zsh --cmd cd)"

# Make prompt redraw faster
setopt prompt_subst

# Aliases
alias shutdown="shutdown now"
alias h=helix
alias o=xdg-open
alias y=yazi
alias m=micromamba
