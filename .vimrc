"
" Plugin Management
" =================
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" Other Plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'klen/python-mode'
Plugin 'wting/rust.vim'
Plugin 'tkztmk/vim-vala'

call vundle#end()

"
" Other options
" =============
"

filetype plugin on
let g:mapleader = '\'

" Syntax hightlighting
" Without the line below, highlighting the current line doesn't work,
" and fixes some background color mismatches in terminal.
let g:solarized_termtrans=1
syntax on
set background=dark
colorscheme solarized

" Misc settings
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set autoindent
set textwidth=80
set formatoptions=qrn1
set colorcolumn=85
set ttimeoutlen=50

" Nice font
set guifont=Inconsolata\ for\ Powerline\ Medium\ 12

" Open all folds by default
au BufWinEnter * normal zR

" Enable wildmenu
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d

" YouCompleteMe settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" Disable YCM for python and some other
let g:ycm_filetypes_to_completely_ignore = {'notes': 1, 'markdown': 1, 'text': 1}

" Python mode settings
let g:pymode_options_max_line_length = 85
let g:pymode_lint_ignore = "E128,E302,W391,W0401"
let g:pymode_lint_on_fly = 1
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

" Recursive lookup for tags file
set tags=./tags;/

" CtrlP settings
" Use mixed mode by default
let g:ctrlp_cmd = 'CtrlPMixed'

" CtrlP for tags
let g:ctrlp_extensions = ['tag', 'buftag']
let g:ctrlp_buftag_types = {
    \ 'javascript': {
    \     'bin': 'jsctags',
    \     'args': '-f -'
    \ },
    \ 'python': '--python-kinds=-i'
\ }

map <C-o> :CtrlPBufTagAll<CR>

" NERDTree keybinding
map <C-n> :NERDTreeToggle<CR>
" Automatically close the window if only a NERDTree window is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Airline options
" Use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"let g:airline_section_z=''

" No annoying sound on errors
set noerrorbells
set novisualbell

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif

" Save as sudo with w!!
cmap w!! %!sudo tee > /dev/null %

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Make sure movement works a I would expect in insert mode
nnoremap j gj
nnoremap k gk

" Disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Highlight current line when in insert mode
autocmd InsertEnter,InsertLeave * set cul!
