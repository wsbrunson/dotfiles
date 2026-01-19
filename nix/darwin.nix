{ pkgs, username, ... }:

{
  # =============================================================================
  # Nix Settings
  # =============================================================================

  # Determinate Nix manages its own daemon, so disable nix-darwin's management
  nix.enable = false;

  # Allow unfree packages (for things like terraform)
  nixpkgs.config.allowUnfree = true;

  # =============================================================================
  # System Packages
  # =============================================================================

  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    curl
    wget
    tree
    jq
    yq

    # Shell & prompt
    fish
    starship
    fzf

    # Dev tools
    gh
    lazygit
    delta # git-delta
    httpie
    hugo

    # Cloud & infrastructure
    awscli2
    # aws-sam-cli  # might need overlay, check nixpkgs
    terraform
    flyctl
    # pscale  # might need overlay

    # Databases
    redis
    sqlc

    # Build dependencies
    cairo
    ffmpeg
    pkg-config

    # Languages & runtimes
    bun
    go
    rustup

    # Go tools (commonly used)
    gopls
    golangci-lint
    air # live reload
    gotools # goimports, etc.

    # AI tools
    claude-code
  ];

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

    # CLI tools that work better via Homebrew or aren't in nixpkgs
    brews = [
    ];

    # GUI applications
    casks = [
      "1password"
      "alacritty"
      "firefox"
      "ghostty"
      "google-chrome"
      "iterm2"
      "numi"
      "rectangle"
      "slack"
      "spotify"
      "visual-studio-code"
      "whisky"
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
      # Minimize to application icon
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
      # Keyboard
      AppleKeyboardUIMode = 3; # Full keyboard control
      InitialKeyRepeat = 15;
      KeyRepeat = 2;

      # Appearance
      AppleInterfaceStyle = "Dark";

      # Scrolling
      NSAutomaticWindowAnimationsEnabled = false;
    };

    # Trackpad
    trackpad = {
      Clicking = true; # Tap to click
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

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # =============================================================================
  # System Programs
  # =============================================================================

  # Enable fish as a valid login shell
  programs.fish.enable = true;

  # Environment variables available system-wide
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # =============================================================================
  # Users
  # =============================================================================

  # Primary user for user-specific settings (homebrew, system.defaults, etc.)
  system.primaryUser = username;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  # =============================================================================
  # Services
  # =============================================================================

  # Enable SSH (Remote Login)
  services.openssh = {
    enable = true;
    extraConfig = ''
      AllowUsers ${username}
    '';
  };

  # =============================================================================
  # System State
  # =============================================================================

  # Used for backwards compatibility
  system.stateVersion = 5;

  # Platform
  nixpkgs.hostPlatform = "aarch64-darwin";
}
