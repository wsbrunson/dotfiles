# cottonmouth: NixOS-specific home-manager configuration

{ config, pkgs, lib, username, dotfilesPath, ... }:

{
  imports = [ ../../modules/home ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # =============================================================================
  # Linux-specific packages
  # =============================================================================

  home.packages = with pkgs; [
    # Add any Linux-specific packages here
  ];

  # =============================================================================
  # Linux-specific config
  # =============================================================================

  # Example: enable a service only on Linux
  # services.syncthing.enable = true;
}
