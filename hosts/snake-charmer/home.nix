# snake-charmer: macOS-specific home-manager configuration

{ config, pkgs, lib, username, dotfilesPath, ... }:

{
  imports = [ ../../modules/home ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  # =============================================================================
  # macOS-specific Git config (work machine includes)
  # =============================================================================

  programs.git.includes = [
    {
      condition = "gitdir:~/workspace/internal/";
      path = "~/.gitconfig-internal";
    }
    {
      condition = "gitdir:~/workspace/one-paypal/";
      path = "~/.gitconfig-one-paypal";
    }
  ];

}
