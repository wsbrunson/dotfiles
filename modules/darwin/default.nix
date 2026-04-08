# Shared nix-darwin configuration
# This module is imported by all macOS hosts

{ pkgs, username, ... }:

{
  imports = [
    ./homebrew.nix
  ];

  # =============================================================================
  # Nix Settings
  # =============================================================================

  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  # =============================================================================
  # macOS System Preferences
  # =============================================================================

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv";
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleInterfaceStyle = "Dark";
      NSAutomaticWindowAnimationsEnabled = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };
  };

  # =============================================================================
  # Security
  # =============================================================================

  security.pam.services.sudo_local.touchIdAuth = true;

  # =============================================================================
  # System Programs
  # =============================================================================

  programs.fish.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # =============================================================================
  # Users
  # =============================================================================

  system.primaryUser = username;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.fish;
  };
}
