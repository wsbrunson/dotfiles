#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ==============================================================================
# Install Homebrew
# ==============================================================================

if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ==============================================================================
# Install packages from Brewfile
# ==============================================================================

echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ==============================================================================
# Stow dotfiles
# ==============================================================================

echo "Stowing dotfiles..."
stow --no-folding -d "$DOTFILES_DIR" -t "$HOME" stow

# ==============================================================================
# Fish shell setup
# ==============================================================================

# Add fish to allowed shells and set as default
FISH_PATH="/opt/homebrew/bin/fish"
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "Setting fish as default shell..."
    chsh -s "$FISH_PATH"
fi

# Install fisher plugins from fish_plugins
echo "Installing fisher plugins..."
fish -c "fisher install < ~/.config/fish/fish_plugins"

# ==============================================================================
# SSH permissions
# ==============================================================================

echo "Setting SSH permissions..."
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config

echo "Done! Restart your terminal to use fish."
