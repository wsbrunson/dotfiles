# ==============================================================================
# Fish Shell Configuration
# ==============================================================================

# Disable fish greeting
set fish_greeting ""

# ==============================================================================
# Environment Detection
# ==============================================================================

# Determine if this is a work or personal environment
set -l current_hostname (hostname)
set -l is_work_machine false

# Check for work-specific indicators
if string match -q "*paypal*" $current_hostname; or test "$USER" = "wbrunson"
    set is_work_machine true
end

# ==============================================================================
# Path Management
# ==============================================================================

# Add paths in order of preference (most specific first)
fish_add_path ~/workspace/dotfiles/scripts
fish_add_path ~/workspace/tools
fish_add_path ~/.local/bin
fish_add_path /opt/homebrew/bin

# Used by the z directory utility
set -U Z_DATA $HOME/.local/share/z/data
set -U Z_DATA_DIR $HOME/.local/share/z

# ==============================================================================
# Work Environment Configuration
# ==============================================================================

if test $is_work_machine = true
    # PayPal-specific NPM mirror
    set -x NVM_NODEJS_ORG_MIRROR "https://artifactory.paypalcorp.com/artifactory/nodejs-dist"
    # Corporate CA bundle for Node.js
    set -x NODE_EXTRA_CA_CERTS ~/.local/certs/combined-ca-bundle.pem
    # Use Homebrew's curl (has corporate CA certs) for brew downloads
    set -gx HOMEBREW_CURL_PATH (brew --prefix curl)/bin/curl
end

# Source secrets (API tokens, etc.) - this file is gitignored
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# ==============================================================================
# Development Tools
# ==============================================================================

# Node Version Manager - only on work machines
if test $is_work_machine = true
    set -x NVM_DIR "$HOME/.nvm"
    if test -s "$NVM_DIR/nvm.sh"
        bass source "$NVM_DIR/nvm.sh" # This loads nvm
    end
end

# OCaml Package Manager
if test -r "$HOME/.opam/opam-init/init.fish"
    source "$HOME/.opam/opam-init/init.fish" >/dev/null 2>/dev/null; or true
end

# ==============================================================================
# Shell Enhancement
# ==============================================================================

# Starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

# ==============================================================================
# Aliases & Editor Configuration
# ==============================================================================

# Claude CLI
# alias claude="$HOME/.claude/local/claude"

# Editor aliases - use neovim everywhere
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

# Set default editors
set -gx EDITOR nvim
set -gx VISUAL nvim
