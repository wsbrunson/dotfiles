# ===============
# ===  CUSTOM ===
# ===============
source ~/.custom_bashrc

# ===============
# ===   PATH  ===
# ===============
PATH=/usr/local/bin:/home/shane/.local/bin:$HOME/.rvm/bin:$PATH

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
# === PYTHON  ===
# ===============
# PATH="/home/shane/.pyenv/bin:$PATH"
# PATH="/home/shane/.poetry/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# ===============
# ===   NODE  ===
# ===============
NODE_MANAGER="nvm"

if [ $NODE_MANAGER = "nvm" ]
then
  source ~/.include_nvm
elif [ $NODE_MANAGER = "fnm" ]
then
  source ~/.include_fnm
fi

# ===============
# === PLUGINS ===
# ===============
source $WORKSPACE/dotfiles/antigen/antigen.zsh

antigen bundle git
antigen bundle dashixiong91/zsh-vscode
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
