# ===============
# ===   ENV   ===
# ===============
if test -e "$HOME/.env"; then
  export $(cat $HOME/.env | xargs)
fi

# ===============
# ===  CUSTOM ===
# ===============
if test -e "$HOME/.customrc"; then
  source $HOME/.customrc
fi


# ===============
# ===   PATH  ===
# ===============
PATH=/usr/local/bin:/home/shane/.local/bin:$HOME/.rvm/bin:/opt/homebrew/bin:$PATH


# ===============
# === EXPORTS ===
# ===============
export WORKSPACE=$HOME/workspace
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# ===============
# ==== ALIAS ====
# ===============
alias workspace="cd $WORKSPACE"
alias dotfiles="cd $WORKSPACE/dotfiles"


# ===============
# ==  STARSHIP ==
# ===============
eval "$(starship init zsh)"


# ===============
# ==    BREW   ==
# ===============
eval "$(/opt/homebrew/bin/brew shellenv)"


# ===============
# === PYTHON  ===
# ===============
# export PATH="~/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"


# ===============
# ===   NODE  ===
# ===============
source ~/.node_manager


# ===============
# ===    GO   ===
# ===============
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"


# ===============
# === PLUGINS ===
# ===============
source $(brew --prefix)/share/antigen/antigen.zsh

antigen bundle git
antigen bundle belak/zsh-utils
antigen bundle dashixiong91/zsh-vscode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle joshskidmore/zsh-fzf-history-search
antigen bundle changyuheng/fz
antigen bundle rupa/z

antigen apply

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
