"
" ---------------------- PRJOECT-SPECIFIC SETTINGS ----------------------
" Configure based on working directory
" web-app-core uses dumb defaults

set noexpandtab                " use spaces instead of tabs
set shiftwidth=4               " when reading, tabs are 2 spaces
set tabstop=4                  " in insert mode, tabs are 2 spaces
set textwidth=120              " no lines longer than 80 cols

" set expandtab                " use spaces instead of tabs
" set shiftwidth=2             " when reading, tabs are 2 spaces
" set tabstop=2                " in insert mode, tabs are 2 spaces
" set textwidth=80             " no lines longer than 80 cols


" turn off shortcut when not working in web-app-core
nnoremap gp :silent %!./node_modules/.bin/prettier-eslint --stdin --printWidth=120 --singleQuote=true --useTabs=true --no-bracket-spacing<CR>

" Turn on Prettier when not working in web-app-core
" let g:ale_fixers = {
"   \ 'javascript': ['prettier'],
"   \ 'reason': ['refmt']
"   \ }

" let g:ale_fix_on_save = 1


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


" ---------------------- Status Line ----------------------
"
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%=
set statusline+=%{LinterStatus()}

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%d Errors | %d Warnings',
    \   all_errors,
    \   all_non_errors,
    \)
endfunction

" ---------------------- Key Mappings ----------------------

let mapleader=" "                  " set space as mapleader

nnoremap <leader>g :silent execute "grep! -R --exclude-dir={\"dist\", \".cache\", \"coverage\", \"flow-typed\", \"node_modules\"} " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" use ESC to remove search higlight
nnoremap <Enter> :noh<return><esc>

" move between last two files
nnoremap <Leader><Leader> <c-^>
nnoremap j gj
nnoremap k gk

" insert blank line below
nnoremap <leader>n o<Esc>

" save with ctrl+s
nmap <leader>s :w<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <leader>q :bp<CR>          " map to buffer next/prev/delete buffer
noremap <leader>w :bn<CR>
noremap <leader>e :bd<CR>

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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bling/vim-bufferline'
Plug 'Raimondi/delimitMate'

" web development plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Elm plugins
Plug 'elmcast/elm-vim', { 'for': 'elm' }

" Ethereum
Plug 'tomlion/vim-solidity'

" Reason
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }

" Themes
Plug 'mhartington/oceanic-next'


" end plugin definition
call plug#end()

" Color Scheme
colorscheme OceanicNext

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
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=node_modules/*,.git/*,flow-typed/*,dist/*,cache/*,coverage/*,system/*,build/*
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|flow-typed\|dist\|cache\|coverage\|system\|.live-deploy'
" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" vim-bufferline
let g:bufferline_modified = '*'
let g:bufferline_show_bufnr = 0
let g:bufferline_active_highlight = 'PmenuSel'
let g:bufferline_pathshorten = 1

" ALE configuration
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow'],
  \ 'reason': ['merlin', 'ols']
  \ }

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" Move between linting errors
nnoremap <Leader>r :ALENextWrap<CR>
nnoremap <Leader>R :ALEPreviousWrap<CR>

" vim-javascript configuration
let g:javascript_plugin_flow = 1

" vim-jsx configuration
let g:jsx_ext_required = 0

" Writing Mode
func! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  set nonumber
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()
