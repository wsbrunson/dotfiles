# Shared packages for all hosts via home-manager
# This replaces modules/shared/packages.nix for unified package management

{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Core utilities
    bat
    eza
    fd
    fzf
    git
    gh
    curl
    wget
    tree
    jq
    ripgrep
    terraform
    yq

    # TUI
    btop           # activity    : https://github.com/aristocratos/btop
    fastfetch      # cool info   : https://github.com/fastfetch-cli/fastfetch
    lazygit        # git         : https://github.com/jesseduffield/lazygit
    lazysql        # sql         : https://github.com/jorgerojas26/lazysql
    lazyssh        # ssh         : https://github.com/Adembc/lazyssh
    spotify-player # spotify     : https://github.com/aome510/spotify-player
    television     # file search : https://github.com/alexpasmantier/television

    # AI tools
    claude-code
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # Linux-only packages
    bluetui   # bluetooth : https://github.com/pythops/bluetui
    ghostty   # terminal
    impala    # WiFi      : https://github.com/pythops/impala
  ];
}
