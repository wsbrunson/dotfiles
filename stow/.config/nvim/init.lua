-- ---------------------- PROJECT-SPECIFIC SETTINGS ----------------------
-- Configure based on working directory
-- web-app-core uses dumb defaults

-- Default settings
vim.opt.expandtab = true      -- use spaces instead of tabs
vim.opt.shiftwidth = 2        -- when reading, tabs are 2 spaces
vim.opt.tabstop = 2           -- in insert mode, tabs are 2 spaces
vim.opt.textwidth = 80        -- no lines longer than 80 cols

-- ---------------------- USABILITY CONFIGURATION ----------------------
-- Basic and pretty much needed settings to provide a solid base for
-- source code editing

vim.cmd('syntax on')          -- turn on syntax highlighting
vim.opt.number = true         -- show line numbers
vim.opt.laststatus = 2        -- for statusline
vim.opt.autoread = true       -- reload files changed outside vim
vim.opt.hidden = true         -- do not unload buffers when they are abandoned
vim.opt.fileformat = 'unix'   -- set unix line endings
vim.opt.lazyredraw = true     -- do not redraw
vim.opt.fileformats = {'unix', 'dos'} -- try unix line endings then dos, use unix for new buffers
vim.opt.backspace = {'indent', 'eol', 'start'} -- normalize backspace in insert
vim.opt.splitbelow = true     -- Open new split panes to right and bottom
vim.opt.splitright = true     -- which feels more natural
vim.opt.incsearch = true      -- find the next match as we type the search
vim.opt.hlsearch = true       -- highlight searches by default
vim.opt.ignorecase = true     -- Make searches case-insensitive
vim.opt.smartcase = true      -- unless the query has capital letters
vim.opt.gdefault = true       -- Use 'g' flag by default with :s/foo/bar/
vim.opt.wildmode = {'list', 'longest'} -- suggestion for normal mode commands

vim.cmd('filetype plugin indent on') -- make vim try to detect file types and load plugins for them

vim.opt.encoding = 'utf-8'    -- encoding is utf 8
vim.opt.fileencoding = 'utf-8'

vim.opt.backup = false        -- remove the .ext~ files, but not the swapfiles
vim.opt.writebackup = true
vim.opt.swapfile = false

vim.opt.autoindent = true     -- autoindent based on line above, works most of the time
vim.opt.smartindent = true    -- smarter indent for C-like languages

-- set up undo options
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
vim.opt.undofile = true
vim.opt.undolevels = 1000     -- maximum number of changes that can be undone
vim.opt.undoreload = 10000    -- maximum number lines to save for undo on a buffer reload

vim.cmd('highlight clear SignColumn') -- use clear color for gutter

-- enable matchit plugin which ships with vim and greatly enhances '%'
vim.cmd('runtime macros/matchit.vim')

-- save when editor loses focus
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wa",
})
vim.opt.autowriteall = true

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- setup yaml file defaults
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- setup go file defaults
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- ---------------------- Key Mappings ----------------------

-- Set leader key
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- use ESC to remove search highlight
vim.keymap.set('n', '<Enter>', ':noh<Return><Esc>', { silent = true })

-- Better j/k navigation for wrapped lines
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })

-- save with leader + s
vim.keymap.set('n', '<leader>s', ':w<CR>', { silent = true })

-- Quicker window movement
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Buffer navigation
vim.keymap.set('n', '<leader>h', ':bp<CR>', { silent = true })  -- h for "previous" 
vim.keymap.set('n', '<leader>l', ':bn<CR>', { silent = true })  -- l for "next"
vim.keymap.set('n', '<leader>d', ':bd<CR>', { silent = true })  -- d for "delete"

-- Move lines with alt-j/k
vim.keymap.set('n', '∆', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '˚', ':m .-2<CR>==', { silent = true })
vim.keymap.set('i', '∆', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '˚', '<Esc>:m .-2<CR>==gi', { silent = true })
vim.keymap.set('v', '∆', ':m \'>+1<CR>gv=gv', { silent = true })
vim.keymap.set('v', '˚', ':m \'<-2<CR>gv=gv', { silent = true })

-- NvimTree toggle
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

-- Relative numbering toggle function
local function number_toggle()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
    vim.opt.number = true
  else
    vim.opt.relativenumber = true
  end
end

-- Toggle between normal and relative numbering
vim.keymap.set('n', '<leader>z', number_toggle, { silent = true })

-- LSP key mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true })

-- Telescope navigation and search
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { silent = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { silent = true })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { silent = true })
vim.keymap.set('n', '<leader>p', '<cmd>Telescope git_files<cr>', { silent = true })
vim.keymap.set('n', '<leader>P', '<cmd>Telescope find_files<cr>', { silent = true })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>', { silent = true })
vim.keymap.set('n', '<leader>*', '<cmd>Telescope grep_string<cr>', { silent = true })
vim.keymap.set('n', '<leader>:', '<cmd>Telescope commands<cr>', { silent = true })

-- Git hunk navigation (gitsigns)
vim.keymap.set('n', '<leader>gn', function() require('gitsigns').next_hunk() end, { silent = true })
vim.keymap.set('n', '<leader>gp', function() require('gitsigns').prev_hunk() end, { silent = true })
vim.keymap.set('n', '<leader>gs', function() require('gitsigns').stage_hunk() end, { silent = true })
vim.keymap.set('n', '<leader>gu', function() require('gitsigns').undo_stage_hunk() end, { silent = true })
vim.keymap.set('n', '<leader>gv', function() require('gitsigns').preview_hunk() end, { silent = true })

-- Quick config editing
vim.keymap.set('n', '<leader>ve', ':e ~/.config/nvim/init.lua<CR>', { silent = true })
vim.keymap.set('n', '<leader>vr', ':source ~/.config/nvim/init.lua<CR>', { silent = true })

-- Terminal mode mappings
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

-- ---------------------- Auto Commands ----------------------

-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler (happens when dropping a file on gvim).
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) and vim.bo.filetype ~= 'gitcommit' then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- .md files are markdown files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

-- ---------------------- PLUGIN CONFIGURATION ----------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- LSP Management
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },

  -- Essential plugins
  "tpope/vim-commentary",
  "tpope/vim-surround", 
  "tpope/vim-repeat",
  "tpope/vim-fugitive",
  "tpope/vim-unimpaired",
  "Raimondi/delimitMate",

  -- Status line
  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        colorscheme = 'wombat',
        active = {
          left = { 
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }
          },
          right = { 
            { 'lineinfo' },
            { 'percent' },
            { 'filetype' }
          }
        },
        component_function = {
          gitbranch = 'fugitive#head'
        }
      }
    end
  },

  -- Indent guides
  {
    "Yggdroot/indentLine",
    config = function()
      vim.g.indentLine_char = '⦙'
    end
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            }
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "target/",
            "build/",
            "dist/"
          },
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.9,
            height = 0.8,
            preview_cutoff = 120,
            horizontal = {
              preview_width = 0.6
            }
          }
        },
        pickers = {
          find_files = { theme = "dropdown" },
          git_files = { theme = "dropdown" },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              }
            }
          }
        }
      }
    end
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls", "ts_ls", "eslint", "pyright" }
      })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup{ capabilities = capabilities }
      lspconfig.eslint.setup{ capabilities = capabilities }

      -- Python  
      lspconfig.pyright.setup{ capabilities = capabilities }

      -- Go
      lspconfig.gopls.setup{
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      -- Lua
      lspconfig.lua_ls.setup{
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = {'vim'} }
          }
        }
      }
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "go", "javascript", "typescript", "python", "lua", "json", "yaml", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", 
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },

  -- Theme
  {
    "catppuccin/nvim", 
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".git", "_build" },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,
            },
          },
        },
        renderer = {
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
            },
          },
        },
      })
    end
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = true
  },

  -- Tmux integration
  "christoomey/vim-tmux-navigator",
})

-- Additional telescope shortcuts
vim.keymap.set('n', '<Leader>o', '<cmd>Telescope find_files<cr>', { silent = true })
vim.keymap.set('n', '<Leader>b', '<cmd>Telescope buffers<cr>', { silent = true })
vim.keymap.set('n', '<Leader>f', '<cmd>Telescope oldfiles<cr>', { silent = true })


