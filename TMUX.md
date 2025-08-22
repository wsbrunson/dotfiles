# Tmux Configuration Guide

This document explains the tmux setup and common commands based on the current configuration.

## Configuration Overview

The tmux setup uses a custom prefix key and optimized settings for development workflows, particularly for vim users.

### Key Features

- **Custom Prefix**: `Ctrl+a` (instead of default `Ctrl+b`)
- **Mouse Support**: Enabled for scrolling and pane selection
- **Vi Mode**: Vi-style key bindings for copy mode
- **Smart Window Numbering**: Windows start at 1, auto-renumber on close
- **Workflow-Optimized**: Fast window switching for common development tasks

## Prefix Key

All tmux commands start with the prefix key: `Ctrl+a`

## Window Management

### Quick Window Switching (No Prefix Required)
- `Alt+1` → Window 1 (lazygit)
- `Alt+2` → Window 2 (vim)
- `Alt+3` → Window 3 (Claude Code)
- `Alt+4` → Window 4

### Alternative Window Switching (macOS Option Key)
- `Option+1` → Window 1
- `Option+2` → Window 2
- `Option+3` → Window 3
- `Option+4` → Window 4

### Prefix-Based Window Navigation
- `Ctrl+a n` → Next window
- `Ctrl+a p` → Previous window

## Pane Management

### Splitting Panes
- `Ctrl+a "` → Split horizontally (new pane below)
- `Ctrl+a %` → Split vertically (new pane to the right)

### Pane Navigation
Uses vim-tmux-navigator plugin for seamless navigation between vim splits and tmux panes:
- `Ctrl+h` → Move to left pane/split
- `Ctrl+j` → Move to bottom pane/split
- `Ctrl+k` → Move to top pane/split
- `Ctrl+l` → Move to right pane/split

## Copy Mode (Vi-Style)

Enter copy mode: `Ctrl+a [`

### Copy Mode Commands
- `v` → Start visual selection
- `Ctrl+v` → Toggle rectangle selection
- `y` → Copy selection and exit copy mode
- `q` → Exit copy mode

## Common Workflows

### Development Setup
1. **Window 1**: `lazygit` for git operations
2. **Window 2**: `nvim` for code editing
3. **Window 3**: `claude` for AI assistance
4. **Window 4**: General terminal tasks

### Quick Workflow Switching
- `Alt+1` → Check git status with lazygit
- `Alt+2` → Edit code in vim
- `Alt+3` → Get AI assistance
- `Alt+4` → Run commands/tests

## Essential Commands

### Session Management
- `tmux new-session -s <name>` → Create named session
- `tmux attach -t <name>` → Attach to session
- `tmux list-sessions` → List all sessions
- `Ctrl+a d` → Detach from session

### Window Operations
- `Ctrl+a c` → Create new window
- `Ctrl+a &` → Kill current window
- `Ctrl+a ,` → Rename current window

### Pane Operations
- `Ctrl+a x` → Kill current pane
- `Ctrl+a z` → Toggle pane zoom
- `Ctrl+a space` → Cycle through pane layouts

## Plugins

This configuration uses the following plugins:

- **TPM**: Plugin manager
- **vim-tmux-navigator**: Seamless vim/tmux navigation
- **catppuccin-tmux**: Mocha theme for visual appeal
- **tmux-yank**: Enhanced copy/paste functionality

## Tips

1. **Mouse Support**: Click to select panes, scroll to navigate history
2. **Path Inheritance**: New panes open in the current directory
3. **Vi Bindings**: If you're a vim user, copy mode will feel familiar
4. **Window Persistence**: Numbers stay consistent even when windows are closed
5. **Quick Access**: Use Alt+number for instant window switching without prefix