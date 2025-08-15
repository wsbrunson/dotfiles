# Neovim Configuration Guide

A modern, productive Neovim setup optimized for web development, Python, and OCaml projects.

## 🚀 Quick Start

1. Install dependencies:
   ```bash
   # Install Neovim
   brew install neovim
   
   # Install ripgrep (for search)
   brew install ripgrep
   
   # For OCaml projects
   opam install ocaml-lsp-server
   ```

2. Place config at `~/.config/nvim/init.vim`

3. Open Neovim and run `:PlugInstall`

4. Restart Neovim and run `:Mason` to install language servers

## 📖 Essential Key Mappings

> **Leader key:** `;` (semicolon)

### File Operations
| Key | Action |
|-----|--------|
| `<leader>s` | Save file |
| `<leader>ve` | Edit Neovim config |
| `<leader>vr` | Reload Neovim config |

### Navigation
| Key | Action |
|-----|--------|
| `<leader>h` | Previous buffer |
| `<leader>l` | Next buffer |
| `<leader>d` | Delete buffer |
| `<C-j/k/h/l>` | Move between splits |
| `<leader>z` | Toggle relative line numbers |
| `gd` | Go to definition (LSP) |
| `gr` | Go to references (LSP) |
| `[d` / `]d` | Previous/Next diagnostic |

### Search & Files
| Key | Action |
|-----|--------|
| `<leader>/` | Search in project (ripgrep) |
| `<leader>*` | Search word under cursor |
| `<leader>p` | Find git files (most common) |
| `<leader>P` | Find all files |
| `<leader>o` | Quick file menu |
| `<leader>b` | Open buffers |
| `<leader>f` | Recent files |
| `<leader>ll` | Search lines in open buffers |
| `<leader>:` | Command palette |

### File Tree
| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree |

### Git Integration
| Key | Action |
|-----|--------|
| `<leader>gn` | Next git hunk |
| `<leader>gp` | Previous git hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gv` | Preview hunk |

### Code Actions
| Key | Action |
|-----|--------|
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>t` | Open terminal |
| `<Esc>` | Exit terminal mode |

### Text Manipulation
| Key | Action |
|-----|--------|
| `Alt+j` (∆) | Move line down |
| `Alt+k` (˚) | Move line up |
| `<Enter>` | Clear search highlight |

## 🔍 Project-Wide Search (Like VSCode)

This setup gives you VSCode-like search capabilities:

### Basic Search
1. **`<leader>/`** - Opens search prompt
2. Type your search term (supports regex)
3. **Enter** - See all matches with preview
4. **Arrow keys** to navigate results
5. **Enter** - Jump to that line in the file

### Search Word Under Cursor
1. Place cursor on any word
2. **`<leader>*`** - Instantly search for that word across project

### Advanced Search Options
- **Case insensitive:** Just type normally (enabled by default)
- **Regex:** `<leader>/` then `function.*async` 
- **File type:** `<leader>/` then `class --type js`

## 📁 File Tree (nvim-tree)

### Basic Usage
- **`<C-n>`** - Toggle file tree
- **Arrow keys** or **hjkl** - Navigate
- **Enter** - Open file
- **o** - Open file but keep cursor in tree

### File Operations
| Key | Action |
|-----|--------|
| `a` | Create file/folder |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `x` | Cut |
| `p` | Paste |
| `R` | Refresh tree |

### View Options
| Key | Action |
|-----|--------|
| `H` | Toggle hidden files |
| `.` | Toggle dotfiles |
| `I` | Toggle git ignored files |

## 🔧 Language Server Features (LSP)

### Code Intelligence
- **Hover documentation:** Place cursor on function/variable, press `K`
- **Go to definition:** `gd` 
- **Find references:** `gr`
- **Rename symbol:** `<leader>rn` (renames across entire project)

### Error Navigation
- **Next error:** `]d`
- **Previous error:** `[d`
- Errors show inline with red squiggly lines

### Code Actions
- **`<leader>ca`** - Show available code actions (auto-fixes, imports, etc.)

## 📝 Auto-completion

Completion appears automatically as you type:

### Navigation
- **Tab** - Next suggestion
- **Shift+Tab** - Previous suggestion  
- **Enter** - Accept suggestion
- **Ctrl+e** - Cancel

### Sources
- LSP completions (functions, variables, types)
- Buffer completions (words from open files)
- Path completions (file paths)
- Snippet completions

## 🌳 Git Integration (GitSigns)

### Visual Indicators
- **Added lines:** Green bar in gutter
- **Modified lines:** Blue bar in gutter  
- **Deleted lines:** Red triangle in gutter

### Hunk Operations
1. **`<leader>gv`** - Preview changes in floating window
2. **`<leader>gs`** - Stage this hunk (like `git add` for just this change)
3. **`<leader>gu`** - Undo staging
4. **`<leader>gn/gp`** - Jump between hunks

### Git Commands (Fugitive)
- **`:Git`** - Interactive git status (like `lazygit` but in vim)
- **`:Git blame`** - See git blame
- **`:Git log`** - View git history

## 🎨 Fuzzy Finding (FZF)

### File Finding
| Command | Description |
|---------|-------------|
| **`:Files`** | All files in directory |
| **`:GFiles`** | Git-tracked files only |
| **`:Buffers`** | Currently open buffers |
| **`:History`** | Recently opened files |

### Content Search  
| Command | Description |
|---------|-------------|
| **`:Rg pattern`** | Search for pattern in files |
| **`:Lines`** | Search lines in open buffers |

### Inside FZF
- **Ctrl+j/k** - Navigate up/down
- **Ctrl+v** - Open in vertical split
- **Ctrl+x** - Open in horizontal split
- **Tab** - Select multiple files
- **Enter** - Open selected file(s)

## 🐙 OCaml-Specific Features

### Language Support
- Syntax highlighting for `.ml` and `.mli` files
- OCaml LSP integration (ocamllsp)
- Proper indentation (2 spaces)
- OCaml-style comments with `gcc`

### OCaml LSP Features
- Type information on hover (`K`)
- Jump to module definitions (`gd`)
- Code lenses (shows inferred types)
- Inlay hints (parameter names, types)
- Error checking with dune integration

## ⚙️ Customization Tips

### Adding Custom Key Mappings
```vim
" Add to your config:
nnoremap <leader>custom :YourCommand<CR>
```

### Installing New Languages
1. **`:Mason`** - Opens LSP installer
2. **`i`** - Install language server
3. Add to `ensure_installed` in config

### Changing Leader Key
```vim
" Change from ; to space:
let mapleader = " "
```

## 🚨 Troubleshooting

### LSP Not Working
1. **`:LspInfo`** - Check if LSP is attached
2. **`:Mason`** - Verify language server is installed
3. **`:checkhealth`** - General health check

### Search Not Finding Files
- Ensure `ripgrep` is installed: `brew install ripgrep`
- Check you're in a project directory

### File Tree Not Showing Git Status
- Ensure you're in a git repository
- **`R`** in file tree to refresh

### Completion Not Working  
- **`:CmpStatus`** - Check completion status
- Ensure LSP is running (`:LspInfo`)

## 💡 Pro Tips

1. **Learn the leader key combos** - They're designed to be memorable
2. **Use `gd` liberally** - Jump to definitions, then `Ctrl+o` to jump back
3. **Preview git hunks** before staging with `<leader>gv`
4. **Use `:Commands`** to discover available commands
5. **The file tree filters build directories** (_build, node_modules)
6. **Terminal integration** works great with tmux setup

## 🔗 Integration with Your Workflow

This config is designed to work with:
- **iTerm tabs** - Each project in its own tab
- **Tmux sessions** - Multiple tools per project (lazygit, nvim, claude-code)
- **Fish shell** - Modern shell with good defaults
- **Project management** - Your `project-setup` script for tmux
