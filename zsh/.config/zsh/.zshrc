#!/usr/bin/env zsh

export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

setopt autocd
setopt interactive_comments
zle_highlight=('paste:none')

#completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) #include hidden files

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal Files to Source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-plugins"

compinit

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/Users/fertigt/.sdkman"
#[[ -s "/Users/fertigt/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/fertigt/.sdkman/bin/sdkman-init.sh"
