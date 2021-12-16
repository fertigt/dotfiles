export ZDOTDIR=$HOME/.config/zsh
export DEFAULT_USER="$(whoami)"
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt autocd

zle_highlight=('paste:none')

# Usage: zsh_load_plugin repo_url plugin_name
#        or just zsh_load_plugin repo_url
function zsh_load_plugin() {
    PLUGIN_REPO_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ $# -eq 2 ]; then
        PLUGIN_NAME=$2
    else
        PLUGIN_NAME=$PLUGIN_REPO_NAME
    fi

    if [ ! -d "$ZDOTDIR/plugins/$PLUGIN_REPO_NAME" ]; then
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_REPO_NAME"
    fi

    source "$ZDOTDIR/plugins/$PLUGIN_REPO_NAME/$PLUGIN_NAME.plugin.zsh" || \
    source "$ZDOTDIR/plugins/$PLUGIN_REPO_NAME/$PLUGIN_NAME.zsh"
}

# Plugins
zsh_load_plugin "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

zsh_load_plugin "zsh-users/zsh-syntax-highlighting"

zsh_load_plugin "zsh-users/zsh-history-substring-search"
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

zsh_load_plugin "MichaelAquilina/zsh-auto-notify" "auto-notify"

zsh_load_plugin "MichaelAquilina/zsh-you-should-use" "you-should-use"
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=BESTMATCH

zsh_load_plugin "agkozak/zsh-z"

# Completions
fpath=($ZDOTDIR/completions $fpath)
autoload -Uz compinit && compinit -i
# Disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false

source ~/.fzf.zsh
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'cat {}' ;;
    *)            fzf "$@" ;;
  esac
}
export FZF_DEFAULT_OPTS="--multi --cycle --height=80%"

zsh_load_plugin "Aloxaf/fzf-tab"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons $realpath -a --group-directories-first'

# Aliases
alias ls="exa --icons -a --group-directories-first"
alias ll="ls -l --git"
alias lg="ll --tree -I .git --git-ignore"
alias gis="git status"
alias gaa="git add ."
alias ga="git add"
alias gc="git commit -m"
alias gpl="git pull"
alias gps="git push"

# Prompt
source "$ZDOTDIR/zsh-prompt"