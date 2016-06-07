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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

Plugin 'nvie/vim-flake8'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tmhedberg/SimpylFold'

Plugin 'wting/rust.vim'
Plugin 'tkztmk/vim-vala'
Plugin 'eagletmt/neco-ghc'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'tikhomirov/vim-glsl'
Plugin 'plasticboy/vim-markdown'
Plugin 'greyblake/vim-preview'

Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

""""""""""""""""""""""""""""""""""""
" Other options
"
filetype plugin on
let g:mapleader = '\'

" Set t_Co to 256, this fixes the colors in the airline pluin
set t_Co=256

" Syntax hightlighting
" Without the line below, highlighting the current line doesn't work,
" and fixes some background color mismatches in terminal.
let g:solarized_termtrans=1
let python_highlight_all=1
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
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
set ttimeoutlen=50

" Nice font
set guifont=Inconsolata\ for\ Powerline\ Medium\ 12

" Recursive lookup for tags file
set tags=./tags;/

" Open all folds by default
au BufWinEnter * normal zR

" Enable wildmenu, laststatus=2 also required for powerline
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d

" Haskell Support for YouCompleteMe using neco-ghc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

"""""""""""""""""""""""""""""""""
" Python Settings

" Python PEP8 checker
let g:flake8_show_in_gutter = 1
let g:flake8_quickfix_location = "botright"
let g:flake8_quickfix_height = 6
autocmd BufWritePost *.py call Flake8()

" Folding
let g:SimpylFold_docstring_preview = 1
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" vim-pandoc settings
" Disable folding
let g:pandoc#modules#disabled = ["folding"]
" Enable hard line breaks
let g:pandoc#formatting#mode = "ha"

" No annoying sound on errors
set noerrorbells
set novisualbell

" Highlight search results
set hlsearch

" Makes search acts like search in modern browsers
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

" Automatically remove trailing whitespace on save for
" some filetypes
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
