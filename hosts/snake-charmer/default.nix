# snake-charmer: macOS (nix-darwin) system configuration

{ pkgs, username, ... }:

{
  imports = [ ../../modules/shared/packages.nix ];

  # =============================================================================
  # Nix Settings
  # =============================================================================

  # Determinate Nix manages its own daemon, so disable nix-darwin's management
  nix.enable = false;

  # Allow unfree packages (for things like terraform)
  nixpkgs.config.allowUnfree = true;

  # =============================================================================
  # Homebrew (managed by nix-darwin)
  # =============================================================================

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted packages
      upgrade = true;
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
    ];

    # GUI applications
    casks = [
      "1password"
      "ghostty"
      "google-chrome"
      "numi"
      "rectangle"
      "slack"
      "spotify"
      "visual-studio-code"
    ];
  };

  # =============================================================================
  # macOS System Preferences
  # =============================================================================

  system.defaults = {
    # Dock
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
      minimize-to-application = true;
    };

    # Finder
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # List view
      FXEnableExtensionChangeWarning = false;
    };

    # Global preferences
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3; # Full keyboard control
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleInterfaceStyle = "Dark";
      NSAutomaticWindowAnimationsEnabled = false;
    };

    # Trackpad
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };

    # Login window
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

  # =============================================================================
  # Services
  # =============================================================================

  services.openssh = {
    enable = true;
    extraConfig = ''
      AllowUsers ${username}
    '';
  };

  # =============================================================================
  # System State
  # =============================================================================

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
