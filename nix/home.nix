{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # =============================================================================
  # Fish Shell
  # =============================================================================

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
    interactiveShellInit = builtins.readFile ../config/fish/config.fish;
  };

  # Link fish config files (but NOT config.fish or fish_variables)
  xdg.configFile."fish/fish_plugins".source = ../config/fish/fish_plugins;
  xdg.configFile."fish/functions" = {
    source = ../config/fish/functions;
    recursive = true;
  };
  xdg.configFile."fish/completions" = {
    source = ../config/fish/completions;
    recursive = true;
  };

  # =============================================================================
  # Starship Prompt
  # =============================================================================

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Link your existing starship config
  xdg.configFile."starship.toml".source = ../config/starship.toml;

  # =============================================================================
  # Git
  # =============================================================================

  programs.git = {
    enable = true;

    includes = [
      {
        condition = "gitdir:~/workspace/internal/";
        path = "~/.gitconfig-internal";
      }
      {
        condition = "gitdir:~/workspace/one-paypal/";
        path = "~/.gitconfig-one-paypal";
      }
    ];

    settings = {
      user = {
        name = "Shane Brunson";
        email = "brunson.ws@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      credential.helper = "!gh auth git-credential";
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

  # =============================================================================
  # Neovim
  # =============================================================================

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Link your existing LazyVim config
  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  # =============================================================================
  # FZF
  # =============================================================================

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # =============================================================================
  # Ghostty Terminal
  # =============================================================================

  xdg.configFile."ghostty" = {
    source = ../config/ghostty;
    recursive = true;
  };

  # =============================================================================
  # Environment Variables
  # =============================================================================

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
