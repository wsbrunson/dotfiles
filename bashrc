PATH=/usr/local/bin:/home/shane/.local/bin:$PATH

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($path $1);
  fi
}

# ===============
# === EXPORTS ===
# ===============
export WORKSPACE=$HOME/workspace/

# ===============
# ==== ALIAS ====
# ===============
alias workspace="cd $WORKSPACE"
alias dotfiles="cd $WORKSPACE/dotfiles"

# ===============
# === PYTHON  ===
# ===============
PATH="/home/shane/.pyenv/bin:$PATH"
PATH="/home/shane/.poetry/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
if [ -f ~/.sproutrc ]; then
  source ~/.sproutrc
fi

# ===============
# ====  FZF  ====
# ===============
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore-dir .git --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ ! -f ~/.custom_bashrc ]] || source ~/.custom_bashrc

