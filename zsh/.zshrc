export ZDOTDIR=$HOME/.config/zsh
export DEFAULT_USER="$(whoami)"
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt autocd

zle_highlight=('paste:none')

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey "^?" backward-delete-char
bindkey "^f" autosuggest-accept

# Functions

fpath=($ZDOTDIR/functions $fpath)
autoload -Uz $fpath[1]/*(.:t) 

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
# export AUTO_NOTIFY_IGNORE+=("bat")

zsh_load_plugin "MichaelAquilina/zsh-you-should-use" "you-should-use"
export YSU_MESSAGE_POSITION="after"
export YSU_MODE=BESTMATCH

zsh_load_plugin "agkozak/zsh-z"

# Completions
# fpath=($ZDOTDIR/completions $fpath)
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit -i
# Disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} l:|=* r:|=*'
zstyle ':completion:*:*:-command-:*' matcher 'm:{a-zA-Z}={A-Za-z}'
 
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
alias ganachefork="ganache --fork https://mainnet.infura.io/v3/fdd096bb3d3a43df80dd08d6a0317560@$(curl -s https://api.blockcypher.com/v1/eth/main | jq --compact-output '.height')"

# Prompt
source "$ZDOTDIR/zsh-prompt"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
