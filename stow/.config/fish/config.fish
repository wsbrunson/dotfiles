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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/shanebrunson/.opam/opam-init/init.fish' && source '/Users/shanebrunson/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
