### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set fish_greeting ""

fish_add_path "/opt/homebrew/bin/"

mise activate fish | source

starship init fish | source
