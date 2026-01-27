# Fish shell configuration

{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
    ];
    # Source our existing config
    interactiveShellInit = builtins.readFile ../../config/fish/config.fish;
  };

  # Link fish config files (but NOT config.fish or fish_variables)
  xdg.configFile."fish/fish_plugins".source = ../../config/fish/fish_plugins;
  xdg.configFile."fish/functions" = {
    source = ../../config/fish/functions;
    recursive = true;
  };
  xdg.configFile."fish/completions" = {
    source = ../../config/fish/completions;
    recursive = true;
  };
}
