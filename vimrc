"
" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

syntax on                      " turn on syntax highlighting
set number                     " and show line numbers
set laststatus=2               " for statusline
set autoread                   " reload files changed outside vim
set hidden                     " dont't unload buffers when they are abandoned
set fileformat=unix            " set unix line endings
set viminfo='100,f1            " save up to 100 marks, enable capital marks
set lazyredraw                 " do not redraw
set fileformats=unix,dos       " try unix line endings then dos, use unix for new buffers
set backspace=indent,eol,start " normalize backspace in insert
set splitbelow                 " Open new split panes to right and bottom
set splitright                 " which feels more natural
set incsearch                  " find the next match as we type the search
set hlsearch                   " hilight searches by default
set ignorecase                 " Make searches case-insensitive.
set smartcase                  " ... unless the query has capital letters.
set gdefault                   " Use 'g' flag by default with :s/foo/bar/.
set wildmode=list:longest      " suggestion for normal mode commands

filetype on                    " make vim try to detect file types and load plugins for them
filetype plugin on             " types and load plugins for them
filetype indent on

set encoding=utf-8             " encoding is utf 8
set fileencoding=utf-8

set nobackup                   " remove the .ext~ files, but not the swapfiles
set writebackup
set noswapfile

set noexpandtab                " use spaces instead of tabs
set autoindent                 " autoindent based on line above, works most of the time
set smartindent                " smarter indent for C-like languages
set shiftwidth=4               " when reading, tabs are 2 spaces
set tabstop=4                  " in insert mode, tabs are 2 spaces
set textwidth=120              " no lines longer than 80 cols

highlight clear SignColumn     " use clear color for gutter

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" set colors
if !has('gui_running')
  set t_Co=256
endif

" ---------------------- Key Mappings ----------------------

let mapleader=" "                  " set space as mapleader

inoremap jk <Esc>                  " escape insert mode with jk
nnoremap ; :                       " Use ; for commands.
nnoremap <Enter> :noh<return><esc> " use ESC to remove search higlight
noremap <leader>a ggVG             " select all mapping
nnoremap <Leader><Leader> <c-^>    " move between last two files

nmap <leader>s :w<CR>              " save with ctrl+s
nnoremap <C-j> <C-w>j              " Quicker window movement
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <leader>q :bp<CR>          " map to buffer next/prev/delete buffer
noremap <leader>w :bn<CR>
noremap <leader>e :bd<CR>

nnoremap ª :m .+1<CR>==            " Move lines with alt-j/k
nnoremap º :m .-2<CR>==
inoremap ª <Esc>:m .+1<CR>==gi
inoremap º <Esc>:m .-2<CR>==gi
vnoremap ª :m '>+1<CR>gv=gv
vnoremap º :m '<-2<CR>gv=gv

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

nnoremap <leader>z :call NumberToggle()<cr> " Toggle between normal and relative numbering.


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
  "   .twig files use html syntax
  autocmd BufNewFile,BufRead *.twig setlocal ft=html
  "   .less files use less syntax
  autocmd BufNewFile,BufRead *.less setlocal ft=less
  "   .jade files use jade syntax
  autocmd BufNewFile,BufRead *.jade setlocal ft=jade
augroup END


" ---------------------- PLUGIN CONFIGURATION ----------------------

" Install Vim Plug if not installed
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
    endif

" initialize vim-plug
call plug#begin('~/.vim/plugged')

" start plugin defintion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'

" web development plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'prettier/vim-prettier', { 'for': ['javascript'] }

" Elm plugins
Plug 'elmcast/elm-vim', { 'for': 'elm' }

" end plugin definition
call plug#end()

" deoplete configuration
let g:deoplete#enable_at_startup = 1

" neosnippets configuration
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets/'

" Ctrl-p configuration
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|flow-typed\|dist\|cache\|coverage\|system'
" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" vim-airline configuration
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'cobalt2'

" ALE configuration
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '🔶'

let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow']
  \ }

let g:ale_fixers = {}

" Move between linting errors
nnoremap <Leader>r :ALENextWrap<CR>
nnoremap <Leader>R :ALEPreviousWrap<CR>

" vim-javascript configuration
let g:javascript_plugin_flow = 1

" vim-jsx configuration
let g:jsx_ext_required = 0

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 120

" number of spaces per indentation level
let g:prettier#config#tab_width = 4

" use tabs over spaces
let g:prettier#config#use_tabs = 'true'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'false'

" none|es5|all
let g:prettier#config#trailing_comma = 'none'

let g:prettier#config#parser = 'babylon'
