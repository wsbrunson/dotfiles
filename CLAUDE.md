# Dotfiles Repository

This repository contains personal configuration files managed using GNU Stow.

## Quick Start

```bash
# Install Homebrew packages
brew bundle

# Symlink all dotfiles to home directory
stow -t ~/ stow

# Install mise-managed tools
mise install
```

## Repository Structure

```
dotfiles/
├── Brewfile              # Homebrew packages and casks
├── scripts/              # Utility scripts (added to PATH)
│   ├── aws-profile       # AWS profile switcher
│   ├── base64-json       # Base64 JSON decoder
│   ├── bootstrap.sh      # Initial machine setup
│   └── convert-aif-to-wav.sh
├── stow/                 # Stow-managed dotfiles (symlinked to ~/)
│   ├── .claude/          # Claude Code configuration
│   │   ├── CLAUDE.md     # Claude Code instructions
│   │   ├── agents/       # Custom Claude agents
│   │   ├── plugins/      # Claude plugins
│   │   └── settings.json
│   ├── .claude.json      # Claude Code settings
│   ├── .config/          # XDG config directory
│   │   ├── fish/         # Fish shell config
│   │   ├── ghostty/      # Ghostty terminal config
│   │   ├── mise/         # mise tool version manager
│   │   ├── nvim/         # Neovim (LazyVim) config
│   │   ├── starship.toml # Starship prompt config
│   │   └── ...
│   ├── .gitconfig        # Git configuration
│   └── .vim/             # Legacy vim files
├── fonts/                # Custom fonts
├── iterm/                # iTerm2 preferences and themes
└── config/               # Misc config files
```

## How Stow Works

GNU Stow creates symlinks from a source directory to a target directory. Running:

```bash
stow -t ~/ stow
```

Creates symlinks in your home directory (`~/`) pointing to files in the `stow/` folder:
- `stow/.config/fish/config.fish` → `~/.config/fish/config.fish`
- `stow/.claude/CLAUDE.md` → `~/.claude/CLAUDE.md`
- etc.

### Managing Dotfiles

**Add a new config file:**
1. Move the file from `~/` to `stow/` preserving the path
2. Run `stow -t ~/ stow` to create the symlink

**Remove a symlinked file:**
```bash
stow -t ~/ -D stow  # Unstow (remove symlinks)
```

**Re-stow after changes:**
```bash
stow -t ~/ -R stow  # Restow (remove and recreate symlinks)
```

## Key Tools

- **Fish Shell**: Primary shell with custom config
- **Neovim**: Editor using LazyVim distribution
- **Starship**: Cross-shell prompt
- **mise**: Development tool version manager (replaces asdf/nvm)
- **Ghostty/iTerm2**: Terminal emulators

## Scripts

Scripts in `scripts/` are automatically available in PATH (added via fish config):

- `aws-profile`: Switch between AWS profiles
- `base64-json`: Decode base64-encoded JSON

## Work vs Personal Environment

The fish config automatically detects work machines (hostname contains "paypal" or user is "wbrunson") and applies work-specific settings like NPM mirrors and API configurations.
