"
" Plugin Management
" =================
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" Other Plugins
Bundle 'Valloric/YouCompleteMe'
Bundle 'altercation/vim-colors-solarized'
Bundle 'plasticboy/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'

"
" Other options
" =============
"

filetype plugin on
let g:mapleader = '\'

" Syntax hightlighting
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
set ruler

" Nice font
set guifont=Inconsolata\ Medium\ 10

" Enable wildmenu
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d

" YouCompleteMe settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" Disable YCM for python and some other
let g:ycm_filetypes_to_completely_ignore = {'notes': 1, 'markdown': 1, 'text': 1}

" CtrlP settings
" Use mixed mode by default
let g:ctrlp_cmd = 'CtrlPMixed'

" NERDTree keybinding
map <C-n> :NERDTreeToggle<CR>
" Automatically close the window if only a NERDTree window is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Airline options
" Use powerline fonts
let g:airline_powerline_fonts = 1
