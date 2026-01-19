# Dotfiles Repository

This repository contains personal configuration files managed using **Nix**, **nix-darwin**, and **home-manager**.

## Quick Start

```bash
# 1. Install Nix (Determinate Systems installer)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh

# 2. Install Homebrew (for GUI apps)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Bootstrap nix-darwin (first time only)
nix run nix-darwin -- switch --flake ~/workspace/dotfiles

# 4. Rebuild after changes
darwin-rebuild switch --flake ~/workspace/dotfiles
```

## Repository Structure

```
dotfiles/
├── flake.nix             # Nix flake entry point
├── flake.lock            # Locked dependencies
├── nix/
│   ├── darwin.nix        # System config (packages, Homebrew, macOS settings)
│   └── home.nix          # User config (fish, git, neovim, etc.)
├── config/               # Config files linked by home-manager
│   ├── fish/             # Fish shell config
│   ├── nvim/             # Neovim (LazyVim) config
│   ├── ghostty/          # Ghostty terminal config
│   ├── starship.toml     # Starship prompt config
│   └── ...
├── scripts/              # Utility scripts (added to PATH)
├── fonts/                # Custom fonts
└── iterm/                # iTerm2 preferences
```

## How It Works

### nix-darwin (darwin.nix)
Manages system-level configuration:
- **System packages**: CLI tools installed via Nix (git, fzf, go, terraform, etc.)
- **Homebrew casks**: GUI apps (1Password, Ghostty, VS Code, etc.)
- **macOS settings**: Dock, Finder, keyboard preferences
- **Shell**: Sets fish as default login shell

### home-manager (home.nix)
Manages user-level configuration:
- **Fish shell**: Plugins (z, fzf-fish, bass) and config
- **Git**: User settings, delta integration, aliases
- **Neovim**: Enabled with LazyVim config linked
- **Starship**: Prompt configuration
- **Dotfile linking**: Links files from `config/` to `~/.config/`

## Daily Usage

```bash
# Rebuild system after config changes
darwin-rebuild switch --flake ~/workspace/dotfiles

# Or use the fish alias
rebuild

# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Garbage collect old generations
nix-collect-garbage -d
```

## Adding Packages

**CLI tools** — Add to `environment.systemPackages` in `nix/darwin.nix`:
```nix
environment.systemPackages = with pkgs; [
  ripgrep  # example
];
```

**GUI apps** — Add to `homebrew.casks` in `nix/darwin.nix`:
```nix
homebrew.casks = [
  "discord"  # example
];
```

## Adding Config Files

Config files in `config/` are linked to `~/.config/` by home-manager.

To add a new config:
1. Add the file to `config/myapp/`
2. Add linking in `nix/home.nix`:
```nix
xdg.configFile."myapp" = {
  source = ../config/myapp;
  recursive = true;
};
```
3. Run `darwin-rebuild switch --flake ~/workspace/dotfiles`

## Key Tools

- **Fish Shell**: Primary shell with custom config
- **Neovim**: Editor using LazyVim distribution
- **Starship**: Cross-shell prompt
- **Ghostty**: Primary terminal emulator
- **Nix**: Declarative package management (replaces Homebrew for CLI tools)

## Scripts

Scripts in `scripts/` are automatically available in PATH:
- `aws-profile`: Switch between AWS profiles
- `base64-json`: Decode base64-encoded JSON

## Work vs Personal Environment

The fish config automatically detects work machines (hostname contains "paypal" or user is "wbrunson") and applies work-specific settings.
