### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set fish_greeting ""

fish_add_path "/opt/homebrew/bin/"
fish_add_path ~/workspace/dotfiles/scripts

mise activate fish | source

starship init fish | source

alias claude="/Users/shanebrunson/.claude/local/claude"

# Completely replace vim with neovim
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

# Set neovim as default editor
set -gx EDITOR nvim
set -gx VISUAL nvim
