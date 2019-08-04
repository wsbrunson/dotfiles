"
" ---------------------- PRJOECT-SPECIFIC SETTINGS ----------------------
" Configure based on working directory
" web-app-core uses dumb defaults

" Default settings. These should mirror the WorkspaceNormal function
set expandtab                " use spaces instead of tabs
set shiftwidth=2             " when reading, tabs are 2 spaces
set tabstop=2                " in insert mode, tabs are 2 spaces
set textwidth=80             " no lines longer than 80 cols

let g:ale_fixers = {
  \ 'json': ['prettier'],
  \ 'css': ['prettier'],
  \ 'html': ['prettier'],
  \ 'javascript': ['eslint'],
  \ }

function! WorkspaceNormal()
	set expandtab                " use spaces instead of tabs
	set shiftwidth=2             " when reading, tabs are 2 spaces
	set tabstop=2                " in insert mode, tabs are 2 spaces
	set textwidth=80             " no lines longer than 80 cols

	let g:ale_fixers = {
	  \ 'json': ['prettier'],
	  \ 'css': ['prettier'],
	  \ 'html': ['prettier'],
	  \ 'javascript': ['eslint'],
	  \ }
endfunc

function! WorkspaceSprout()
	set noexpandtab                " use tabs instead of spaces
	set shiftwidth=4               " when reading, tabs are 4 spaces
	set tabstop=4                  " in insert mode, tabs are 4 spaces
	set textwidth=120              " no lines longer than 120 cols

	let g:ale_fixers = {
	  \ 'json': [],
	  \ 'css': [],
	  \ 'html': [],
	  \ 'javascript': ['prettier-eslint'],
	  \ }
endfunc

command WorkspaceNormal :call WorkspaceNormal()
command WorkspaceSprout :call WorkspaceSprout()

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

set autoindent                 " autoindent based on line above, works most of the time
set smartindent                " smarter indent for C-like languages

" set up undo options
set undodir=~/.vim/undodir
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

" ---------------------- Key Mappings ----------------------

let mapleader = ";"
noremap . ;
noremap <Space> .

" use ESC to remove search higlight
nnoremap <Enter> :noh<return><esc>

nnoremap j gj
nnoremap k gk

" save with leader + s
nmap <leader>s :w<CR>
" quit with leader + a
nmap <leader>a :a<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <leader>q :bp<CR>          " map to buffer next/prev/delete buffer
noremap <leader>w :bn<CR>
noremap <leader>e :bd<CR>
noremap <leader>E :bd!<CR>

" Move lines with alt-j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

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

" This searches for the text under the cursor and shows the results in a “quickfix” window
nnoremap K :Ag <C-R><C-W><CR>

" Grep for anything after pressing leader a
nnoremap <leader>a :Ag<SPACE><Paste>

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
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
    endif

" initialize vim-plug
call plug#begin('~/.vim/plugged')

" start plugin defintion
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" auto-complete
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" web development plugins
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx' 
Plug 'leafgarland/typescript-vim'
Plug 'mustache/vim-mustache-handlebars'

" Themes
Plug 'mhartington/oceanic-next' " OceanicNext
Plug 'balanceiskey/gloom-vim'   " gloom-vim
Plug 'cseelus/vim-colors-tone'  " tone

" end plugin definition
call plug#end()

" Color Scheme
colorscheme OceanicNext

" Open file menu
nnoremap <Leader>o :Files<CR>
" Open buffer menu
nnoremap <Leader>b :Buffers<CR>
" Open most recently used files
nnoremap <Leader>f :History<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ALE configuration
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ }

" Move between linting errors
nnoremap <Leader>r :ALENextWrap<CR>
nnoremap <Leader>R :ALEPreviousWrap<CR>

" vim-javascript configuration
let g:javascript_plugin_flow = 1

" vim-jsx configuration
let g:jsx_ext_required = 0

" vim-mustache
autocmd BufNewFile,BufRead *.stache set syntax=mustache

" ---------------------- STATUS LINE ----------------------
let g:lightline = {
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

" ---------------------- COC CONFIG ----------------------
" " Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
