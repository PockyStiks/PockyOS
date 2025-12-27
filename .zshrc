# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pockystiks/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# — Pure prompt
# .zshrc
fpath+=($HOME/.zsh/pure)
autoload -Uz promptinit
promptinit
prompt pure

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Make prompt redraw faster
setopt prompt_subst

alias h=helix
alias shutdown="shutdown now"
