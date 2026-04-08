# Git configuration

{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Shane Brunson";
        email = "brunson.ws@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      # Git stacks credential helpers from all config levels (system, global, user).
      # The Nix-built git package ships with osxkeychain in its system gitconfig,
      # which runs first and returns cached tokens — often for the wrong GitHub
      # account (personal vs work). Setting "" as the first entry clears the
      # inherited helper chain so only gh auth is used.
      credential.helper = [
        ""
        "!gh auth git-credential"
      ];
      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
    };
  };
}
