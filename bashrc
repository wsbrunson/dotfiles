PATH=/usr/local/bin:$PATH

# ===============
# === EXPORTS ===
# ===============

export SPROUT_LDAP_USER="shaneb"
export PATH=$PATH:/usr/local/m-cli
export WORKSPACE=$HOME/workspace/

# ===============
# ==== ALIAS ====
# ===============
alias vim="nvim"

alias workspace="cd $WORKSPACE"
alias quiz="cd $WORKSPACE/quizsimply.com/"
alias wedding="cd $WORKSPACE/shanelovesmaria.com/"
alias home="cd $HOME"
alias blog="cd $WORKSPACE/wsbrunson.com"
alias tcompose="cd $WORKSPACE/twitterCompose/"
alias connect-test="ssh shaneb@test-dev"
alias connect-stage="ssh shaneb@stage-internal-web-dfw-01"
alias webapp="cd $WORKSPACE/web-app-core"
alias dotfiles="cd $HOME/dotfiles"

alias deploy-botscustomers="TESTSITE=botsCustomers yarn run deploy-sandbox"
alias deploy-bots="TESTSITE=bots yarn run deploy-sandbox"
alias deploy-shaneb="TESTSITE=shaneb yarn run deploy-sandbox"
alias deploy-shaneb2="TESTSITE=shaneb2 yarn run deploy-sandbox"

alias rm-cache="rm -rf ~/workspace/web-app-core/.cache/"

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
