PATH=/usr/local/bin:$PATH

# ===============
# === EXPORTS ===
# ===============

export PATH=$PATH:/usr/local/m-cli
export PATH=${PATH}:/usr/local/mysql/bin
export WORKSPACE=$HOME/workspace/

# ===============
# ==== ALIAS ====
# ===============
alias workspace="cd $WORKSPACE"
alias dotfiles="cd $HOME/dotfiles"
alias python="python3"
alias vim="nvim"

# ===============
# ===== NVM =====
# ===============

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
if [ -f ~/.sproutrc ]; then
  source ~/.sproutrc
fi
