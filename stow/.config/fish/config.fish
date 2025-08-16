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
fish_add_path /opt/homebrew/bin

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/wbrunson/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ==============================================================================
# Work Environment Configuration
# ==============================================================================

if test $is_work_machine = true
    # PayPal-specific NPM mirror
    set -x NVM_NODEJS_ORG_MIRROR "https://artifactory.paypalcorp.com/artifactory/nodejs-dist"
    
    # Anthropic API configuration for work
    set -x ANTHROPIC_BASE_URL "https://aiplatform.dev51.cbf.dev.paypalinc.com/cosmosai/llm/v1"
    set -x ANTHROPIC_AUTH_TOKEN "6a69b54fadd8a3d3fa630f9656179884961659609630e870ca47467d4bee8b8c"
    set -x ANTHROPIC_MODEL "claude-sonnet-4-20250514"
    set -x ANTHROPIC_SMALL_FAST_MODEL "claude-3-5-haiku-20241022"
end

# ==============================================================================
# Development Tools
# ==============================================================================

# Mise (development environment manager) - used on all machines
if command -v mise >/dev/null
    mise activate fish | source
end

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
alias claude="$HOME/.claude/local/claude"

# Editor aliases - use neovim everywhere
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

# Set default editors
set -gx EDITOR nvim
set -gx VISUAL nvim