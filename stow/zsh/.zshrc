# ===============
# ===   ENV   ===
# ===============
if test -e "$HOME/.env"; then
  export $(cat $HOME/.env | xargs)
fi

# ===============
# ===  CUSTOM ===
# ===============
if test -e "$HOME/.custom_bashrc"; then
  source $HOME/.custom_bashrc
fi


# ===============
# ===   PATH  ===
# ===============
PATH=/usr/local/bin:/home/shane/.local/bin:$HOME/.rvm/bin:/opt/homebrew/bin:$PATH


# ===============
# === EXPORTS ===
# ===============
export WORKSPACE=$HOME/workspace

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
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"


# ===============
# ===   NODE  ===
# ===============
source ~/.node_manager


# ===============
# === PLUGINS ===
# ===============
source $WORKSPACE/dotfiles/antigen/antigen.zsh

antigen bundle git
antigen bundle dashixiong91/zsh-vscode
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
