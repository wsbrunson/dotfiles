# Dotfiles Repository

This repository contains personal configuration files managed using **Homebrew**, **GNU Stow**, and **shell scripts**.

## Quick Start

```bash
# 1. Run the setup script (installs Homebrew, packages, stows configs, sets up fish)
./setup.sh

# 2. Apply macOS system preferences
./macos-defaults.sh

# 3. Create secrets file (never committed)
touch ~/.config/fish/secrets.fish
```

## Repository Structure

```
dotfiles/
├── Brewfile              # Homebrew packages and casks
├── setup.sh              # Bootstrap script (Homebrew, stow, fish setup)
├── macos-defaults.sh     # macOS system preferences
├── stow/                 # Stow packages (symlinked to $HOME)
├── config/               # App config files
│   ├── fish/             # Fish shell config
│   ├── nvim/             # Neovim (LazyVim) config
│   ├── ghostty/          # Ghostty terminal config
│   ├── git/              # Git config includes
│   ├── gh/               # GitHub CLI config
│   ├── gcloud/           # Google Cloud config
│   ├── starship.toml     # Starship prompt config
│   └── gitconfig         # Main git config
├── scripts/              # Utility scripts (added to PATH)
├── fonts/                # Custom fonts
└── iterm/                # iTerm2 preferences
```

## How It Works

### Setup Flow

1. **`setup.sh`** — Installs Homebrew, runs `brew bundle` from `Brewfile`, stows dotfiles, sets fish as default shell, installs fisher plugins
2. **`macos-defaults.sh`** — Applies macOS preferences (Dock, Finder, keyboard, trackpad, dark mode, Touch ID for sudo)
3. **Stow** — Symlinks config files from `stow/` into `$HOME` using `stow --no-folding`

### Adding Packages

**CLI tools** — Add to `Brewfile`:
```ruby
brew "ripgrep"
```

**GUI apps** — Add casks to `Brewfile`:
```ruby
cask "discord"
```

Then run `brew bundle --file=Brewfile`.

### Adding Config Files

Config files go in `config/` and are linked into `~/.config/` via stow.

To add a new config:
1. Add the files to the appropriate stow package directory
2. Re-run: `stow --no-folding -d . -t $HOME stow`

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

## Key Tools

- **Fish Shell**: Primary shell with custom config
- **Neovim**: Editor using LazyVim distribution
- **Starship**: Cross-shell prompt
- **Ghostty**: Primary terminal emulator
- **Homebrew**: Package management (CLI tools and GUI apps)
- **GNU Stow**: Symlink manager for dotfiles

## Scripts

Scripts in `scripts/` are available in PATH:
- `aws-profile`: Switch between AWS profiles
- `base64-json`: Decode base64-encoded JSON
- `ccswitch`: Claude Code switcher

## Work vs Personal Environment

The fish config detects work machines (hostname contains "paypal" or user is "wbrunson") and applies work-specific settings like NPM mirrors. Secrets (API tokens) are loaded from `~/.config/fish/secrets.fish` on all machines.
