# Shared Homebrew configuration for all macOS hosts

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "mlb-rs/mlbt"
    ];

    brews = [
      "mlb-rs/mlbt/mlbt"
      # "lazycut"           # video cut   : https://github.com/ozemin/lazycut
    ];

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
}
