### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/wbrunson/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set fish_greeting ""

fish_add_path "/opt/homebrew/bin/"
fish_add_path ~/workspace/dotfiles/scripts
fish_add_path /opt/homebrew/bin/
fish_add_path ~/workspace/tools

set -x NVM_NODEJS_ORG_MIRROR "https://artifactory.paypalcorp.com/artifactory/nodejs-dist"

set -x NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"
    bass source "$NVM_DIR/nvm.sh" # This loads nvm
end

set -x ANTHROPIC_BASE_URL "https://aiplatform.dev51.cbf.dev.paypalinc.com/cosmosai/llm/v1"
set -x ANTHROPIC_AUTH_TOKEN "6a69b54fadd8a3d3fa630f9656179884961659609630e870ca47467d4bee8b8c"
set -x ANTHROPIC_MODEL "claude-sonnet-4-20250514"
set -x ANTHROPIC_SMALL_FAST_MODEL "claude-3-5-haiku-20241022"


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
alias claude="/Users/wbrunson/.claude/local/claude"
