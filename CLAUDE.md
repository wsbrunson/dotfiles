# Dotfiles Repository

This repository contains personal configuration files managed using **Nix**, **nix-darwin**, and **home-manager**.

## Quick Start

```bash
# 1. Install Nix (Determinate Systems installer)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh

# 2. Install Homebrew (for GUI apps)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Bootstrap nix-darwin (first time only, use your host name)
nix run nix-darwin -- switch --flake ~/workspace/dotfiles#work-mac

# 4. Rebuild after changes
darwin-rebuild switch --flake ~/workspace/dotfiles#work-mac
```

## Repository Structure

```
dotfiles/
├── flake.nix             # Nix flake entry point (defines all hosts)
├── flake.lock            # Locked dependencies
├── hosts/                # Host-specific configurations
│   ├── snake-charmer/    # Personal Mac (nix-darwin)
│   │   ├── default.nix   # System config
│   │   └── home.nix      # User config
│   ├── work-mac/         # Work Mac (nix-darwin)
│   │   ├── default.nix   # System config (work Homebrew casks, mlbt)
│   │   └── home.nix      # User config (work git includes, PayPal GitHub)
│   └── cottonmouth/      # NixOS server
│       ├── default.nix   # System config
│       └── home.nix      # User config
├── modules/              # Shared, reusable modules
│   └── home/             # Home-manager modules (all hosts import these)
│       ├── default.nix   # Imports all submodules
│       ├── fish.nix      # Fish shell
│       ├── git.nix       # Git + delta
│       ├── neovim.nix    # Neovim/LazyVim
│       ├── packages.nix  # CLI packages
│       └── starship.nix  # Starship prompt
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

### Multi-Host Architecture

Each host has its own directory under `hosts/` with:
- `default.nix` — system-level config (packages, Homebrew casks, macOS settings)
- `home.nix` — user-level config that imports shared modules and adds host-specific overrides

Shared configuration lives in `modules/home/` and is imported by all hosts.

### Rebuilding

Target a specific host with `#hostname`:
```bash
# Work Mac
darwin-rebuild switch --flake ~/workspace/dotfiles#work-mac

# Personal Mac
darwin-rebuild switch --flake ~/workspace/dotfiles#snake-charmer

# NixOS
sudo nixos-rebuild switch --flake ~/workspace/dotfiles#cottonmouth
```

### nix-darwin (hosts/*/default.nix)
Manages system-level configuration:
- **System packages**: CLI tools installed via Nix
- **Homebrew casks**: GUI apps (1Password, Ghostty, VS Code, etc.)
- **macOS settings**: Dock, Finder, keyboard preferences
- **Shell**: Sets fish as default login shell

### home-manager (hosts/*/home.nix + modules/home/)
Manages user-level configuration:
- **Fish shell**: Plugins (z, fzf-fish, bass) and config
- **Git**: User settings, delta integration, aliases
- **Neovim**: Enabled with LazyVim config linked
- **Starship**: Prompt configuration
- **Dotfile linking**: Links files from `config/` to `~/.config/`

## Secrets

API tokens and credentials go in `~/.config/fish/secrets.fish`. This file is:
- Sourced by fish on startup (via `config/fish/config.fish`)
- Listed in `.gitignore` — never committed
- Must be created manually on each machine

Example:
```fish
set -gx ANTHROPIC_BASE_URL "https://..."
set -gx ANTHROPIC_AUTH_TOKEN "..."
```

## Daily Usage

```bash
# Rebuild system after config changes
darwin-rebuild switch --flake ~/workspace/dotfiles#work-mac

# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Garbage collect old generations
nix-collect-garbage -d
```

## Adding Packages

**CLI tools** — Add to `home.packages` in `modules/home/packages.nix`:
```nix
home.packages = with pkgs; [
  ripgrep  # example
];
```

**GUI apps** — Add to `homebrew.casks` in the host's `default.nix`:
```nix
homebrew.casks = [
  "discord"  # example
];
```

## Adding Config Files

Config files in `config/` are linked to `~/.config/` by home-manager.

To add a new config:
1. Add the file to `config/myapp/`
2. Add linking in `modules/home/` (or the host's `home.nix` if host-specific):
```nix
xdg.configFile."myapp" = {
  source = ../../config/myapp;
  recursive = true;
};
```
3. Rebuild: `darwin-rebuild switch --flake ~/workspace/dotfiles#work-mac`

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

The fish config detects work machines (hostname contains "paypal" or user is "wbrunson") and applies work-specific settings like NPM mirrors. Secrets (API tokens) are loaded from `~/.config/fish/secrets.fish` on all machines.
