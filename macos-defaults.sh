#!/bin/bash
set -e

echo "Applying macOS defaults..."

# ==============================================================================
# Dock
# ==============================================================================

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool false

# ==============================================================================
# Finder
# ==============================================================================

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ==============================================================================
# Keyboard
# ==============================================================================

defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# ==============================================================================
# Appearance
# ==============================================================================

defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# ==============================================================================
# Trackpad
# ==============================================================================

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# ==============================================================================
# Login Window
# ==============================================================================

sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# ==============================================================================
# Touch ID for sudo
# ==============================================================================

if [ ! -f /etc/pam.d/sudo_local ]; then
    echo "Enabling Touch ID for sudo..."
    echo "auth       sufficient     pam_tid.so" | sudo tee /etc/pam.d/sudo_local
fi

# ==============================================================================
# Apply changes
# ==============================================================================

echo "Restarting affected apps..."
killall Dock
killall Finder
killall SystemUIServer 2>/dev/null || true

echo "macOS defaults applied."
