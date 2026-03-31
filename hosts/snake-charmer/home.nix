# snake-charmer: macOS-specific home-manager configuration

{ config, pkgs, lib, username, dotfilesPath, ... }:

{
  imports = [ ../../modules/home ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

}
