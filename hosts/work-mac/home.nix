# work-mac: Work-specific home-manager configuration

{ config, pkgs, lib, username, dotfilesPath, ... }:

{
  imports = [ ../../modules/home ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  # =============================================================================
  # Work-specific Git config
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
    # PayPal GitHub credential - uses multiple helper lines
    # (reset + set) which nix attrs can't express
    { path = "~/.gitconfig-paypal"; }
  ];

  # Corporate CA bundle for SSL
  programs.git.settings.http.sslCAInfo = "~/.local/certs/combined-ca-bundle.pem";
}
