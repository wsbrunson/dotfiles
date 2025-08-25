" ---------------------- PROJECT-SPECIFIC SETTINGS ----------------------
" Configure based on working directory
" web-app-core uses dumb defaults

" Default settings. These should mirror the WorkspaceNormal function
set expandtab                " use spaces instead of tabs
set shiftwidth=2             " when reading, tabs are 2 spaces
set tabstop=2                " in insert mode, tabs are 2 spaces
set textwidth=80             " no lines longer than 80 cols

"
" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

syntax on                      " turn on syntax highlighting
set number                     " and show line numbers
set laststatus=2               " for statusline
set autoread                   " reload files changed outside vim
set hidden                     " do not unload buffers when they are abandoned
set fileformat=unix            " set unix line endings
set lazyredraw                 " do not redraw
set fileformats=unix,dos       " try unix line endings then dos, use unix for new buffers
set backspace=indent,eol,start " normalize backspace in insert
set splitbelow                 " Open new split panes to right and bottom
set splitright                 " which feels more natural
set incsearch                  " find the next match as we type the search
set hlsearch                   " highlight searches by default
set ignorecase                 " Make searches case-insensitive.
set smartcase                  " ... unless the query has capital letters.
set gdefault                   " Use 'g' flag by default with :s/foo/bar/.
set wildmode=list:longest      " suggestion for normal mode commands

filetype plugin indent on      " make vim try to detect file types and load plugins for them

set encoding=utf-8             " encoding is utf 8
set fileencoding=utf-8

set nobackup                   " remove the .ext~ files, but not the swapfiles
set writebackup
set noswapfile

set autoindent                 " autoindent based on line above, works most of the time
set smartindent                " smarter indent for C-like languages

" set up undo options
set undodir=~/.local/share/nvim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

highlight clear SignColumn     " use clear color for gutter

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" save when editor loses focus
:au FocusLost * silent! wa
:set autowriteall

set timeoutlen=1000 ttimeoutlen=0

if (has("termguicolors"))
  set termguicolors
 endif

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" setup yaml file defaults
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" setup go file defaults
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd BufWritePre *.go lua vim.lsp.buf.format()

" ---------------------- Key Mappings ----------------------

nnoremap <SPACE> <Nop>
let mapleader=" "

" use ESC to remove search higlight
nnoremap <Enter> :noh<return><esc>

nnoremap j gj
nnoremap k gk

" save with leader + s
nmap <leader>s :w<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <leader>h :bp<CR>          " h for "previous" 
noremap <leader>l :bn<CR>          " l for "next"
noremap <leader>d :bd<CR>          " d for "delete"

" Move lines with alt-j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

nnoremap <C-n> :NvimTreeToggle<CR>

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>z :call NumberToggle()<cr>

" LSP key mappings
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d :lua vim.diagnostic.goto_next()<CR>

" Telescope navigation and search
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>p <cmd>Telescope git_files<cr>
nnoremap <leader>P <cmd>Telescope find_files<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>
nnoremap <leader>: <cmd>Telescope commands<cr>

" Git hunk navigation (since you have gitsigns)
nnoremap <leader>gn :lua require('gitsigns').next_hunk()<CR>
nnoremap <leader>gp :lua require('gitsigns').prev_hunk()<CR>
nnoremap <leader>gs :lua require('gitsigns').stage_hunk()<CR>
nnoremap <leader>gu :lua require('gitsigns').undo_stage_hunk()<CR>
nnoremap <leader>gv :lua require('gitsigns').preview_hunk()<CR>

" Quick config editing
nnoremap <leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>vr :source ~/.config/nvim/init.vim<CR>

" Terminal mode mappings
nnoremap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>

" ---------------------- Auto Commands ----------------------

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " On file types...
  "   .md files are markdown files
  autocmd BufNewFile,BufRead *.md setlocal ft=markdown
augroup END

" ---------------------- PLUGIN CONFIGURATION ----------------------

" Install Vim Plug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" start plugin defintion
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'

" Modern fuzzy finder and picker
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Themes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Better file explorer than NERDTree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Modern git signs in gutter
Plug 'lewis6991/gitsigns.nvim'

" Tmux integration that works great with neovim
Plug 'christoomey/vim-tmux-navigator'

" end plugin definition
call plug#end()

" Color Scheme
colorscheme catppuccin-mocha " catppuccin catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" Additional telescope shortcuts
nnoremap <Leader>o <cmd>Telescope find_files<cr>
nnoremap <Leader>b <cmd>Telescope buffers<cr>
nnoremap <Leader>f <cmd>Telescope oldfiles<cr>

" indent
let g:indentLine_char = '⦙'

lua << EOF
-- nvim-tree setup
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

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "javascript", "typescript", "python", "lua", "json", "yaml", "html", "css" },
  highlight = { enable = true },
  indent = { enable = true },
}

-- gitsigns setup
require('gitsigns').setup()

-- Telescope setup
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
    find_files = {
      theme = "dropdown"
    },
    git_files = {
      theme = "dropdown"
    },
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

-- Mason setup (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "lua_ls", "ts_ls", "eslint", "pyright" }
})

-- nvim-cmp setup
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

-- LSP configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript/JavaScript
lspconfig.ts_ls.setup{
  capabilities = capabilities
}
lspconfig.eslint.setup{
  capabilities = capabilities
}

-- Python  
lspconfig.pyright.setup{
  capabilities = capabilities
}

-- Go
lspconfig.gopls.setup{
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
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
EOF

" ---------------------- STATUS LINE ----------------------
let g:lightline = {
 	\ 'colorscheme': 'wombat',
    \ 'active': {
    \ 'left':  [ [ 'mode', 'paste' ],
    \            [ 'gitbranch', 'readonly', 'filename', 'modified' ]
	\		   ],
	\ 'right': [ [ 'lineinfo' ],
	\            [ 'percent' ],
	\            [ 'filetype' ]
    \   	   ]
	\ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
	\ },
	\ }

