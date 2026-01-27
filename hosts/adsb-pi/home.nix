# adsb-pi: Standalone home-manager configuration for Raspberry Pi 5
# Running Debian (not NixOS) - uses standalone home-manager

{ config, pkgs, lib, username, dotfilesPath, ... }:

{
  imports = [ ../../modules/home ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # =============================================================================
  # Pi-specific packages
  # =============================================================================

  home.packages = with pkgs; [
    # Add any Pi-specific packages here
  ];

  # =============================================================================
  # Pi-specific overrides
  # =============================================================================

  # Disable ghostty config linking (headless server)
  xdg.configFile."ghostty".enable = false;
}
