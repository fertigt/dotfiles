export ZDOTDIR=$HOME/.config/zsh
export DEFAULT_USER="$(whoami)"
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt autocd

zle_highlight=('paste:none')

# todo lazy loading
# Usage: zsh_install_plugin( repo_url, plugin_name)
function zsh_install_plugin() {
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
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

source "$ZDOTDIR/plugins/zsh-syntax-highlight/zsh-syntax-highlight.plugin.zsh"

source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

source "$ZDOTDIR/plugins/zsh-auto-notify/auto-notify.plugin.zsh"

source "$ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh"
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=BESTMATCH

source "$ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh"

# Aliases
alias ls="exa --icons -a --group-directories-first"
alias ll="ls -l --git"
alias lg="ll --tree -I .git --git-ignore"
