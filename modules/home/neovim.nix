# Neovim configuration

{ config, pkgs, lib, dotfilesPath, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Link LazyVim config (mkOutOfStoreSymlink keeps it writable for lazy-lock.json)
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/nvim";
}
