# Shared system packages for all hosts

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utilities
    bat
    eza
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

    # Cloud & infrastructure
    awscli2
    terraform

    # AI tools
    claude-code

    # Terminal
    ghostty
  ];
}
