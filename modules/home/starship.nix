# Starship prompt configuration

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Link existing starship config
  xdg.configFile."starship.toml".source = ../../config/starship.toml;
}
