# Shared home-manager configuration
# This module is imported by both macOS and NixOS hosts

{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # =============================================================================
  # Direnv (auto-load nix flake dev shells)
  # =============================================================================

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # =============================================================================
  # FZF
  # =============================================================================

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # =============================================================================
  # Environment Variables
  # =============================================================================

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # =============================================================================
  # Ghostty Terminal
  # =============================================================================

  xdg.configFile."ghostty" = {
    source = ../../config/ghostty;
    recursive = true;
  };
}
