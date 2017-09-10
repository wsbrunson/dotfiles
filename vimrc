" 
" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

" don't make vim compatible with vi 
set nocompatible

" turn on syntax highlighting
syntax on
" and show line numbers
set number

" make vim try to detect file types and load plugins for them  
filetype on
filetype plugin on     " types and load plugins for them
filetype indent on
set laststatus=1

set autoread           " reload files changed outside vim

set encoding=utf-8     " encoding is utf 8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" dont't unload buffers when they are abandoned,
" instead stay in the background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

if !has('gui_running')
  set t_Co=256
endif

" ---------------------- CUSTOMIZATION ----------------------
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience

" set , as mapleader
let mapleader = ","

" map <leader>q and <leader>w to buffer prev/next buffer
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" save with ctrl+s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" bind vim navigation to tab switch. use Ctrl + l/h/n
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
set ignorecase       " Make searches case-insensitive.
" use ESC to remove search higlight
nnoremap <Enter> :noh<return><esc>

" suggestion for normal mode commands
set wildmode=list:longest

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=2    " when reading, tabs are 2 spaces
set softtabstop=2   " in insert mode, tabs are 2 spaces

" no lines longer than 80 cols
set textwidth=80

" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>

" On file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   .twig files use html syntax
autocmd BufNewFile,BufRead *.twig setlocal ft=html
"   .less files use less syntax
autocmd BufNewFile,BufRead *.less setlocal ft=less
"   .jade files use jade syntax
autocmd BufNewFile,BufRead *.jade setlocal ft=jade

" when pasting over SSH it's a pain to type :set paste and :set nopaste
" just map it to <f9>
set pastetoggle=<f9>

" select all mapping
noremap <leader>a ggVG

" ---------------------- PLUGIN CONFIGURATION ----------------------
" initiate Vundle
let &runtimepath.=',$HOME/.vim/bundle/Vundle.vim'
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" start plugin defintion
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'

" web development plugins
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" end plugin definition
call vundle#end()            " required for vundle

" Ctrl-p configuration
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp\|build\|flow-typed$',
  \ }

" vim-airline configuration
let g:airline_theme = 'powerlineish'
let g:airline#extensions#ale#enabled = 1

" ALE configuration
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'

" UltiSnips configuration
let g:UltiSnipsSnippetDirectories = ['~/.vim/custom_snippets']
let g:UltiSnipsExpandTrigger = '<CR>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'

" vim-javascript configuration
let g:javascript_plugin_flow = 1

" vim-jsx configuration
let g:jsx_ext_required = 0
