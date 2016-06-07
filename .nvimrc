"
" Plugin Management
" =================
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/bundle')

Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py --clang-completer --system-libclang --racer-completer' }
Plug 'altercation/vim-colors-solarized'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'nvie/vim-flake8'
Plug 'wting/rust.vim'
Plug 'tkztmk/vim-vala'
Plug 'christoomey/vim-tmux-navigator'
Plug 'greyblake/vim-preview'
Plug 'tikhomirov/vim-glsl'

call plug#end()

"
" Other options
" =============
"

filetype plugin on
let g:mapleader = '\'

" Set t_Co to 256, this fixes the colors in the airline pluin
set t_Co=256

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
set colorcolumn=80
set ttimeoutlen=50

" Nice font
set guifont=Inconsolata\ for\ Powerline\ Medium\ 12

" Open all folds by default
au BufWinEnter * normal zR

" Enable wildmenu, laststatus=2 also required for powerline
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d

" YouCompleteMe settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_filetypes_to_completely_ignore = {'notes': 1, 'markdown': 1, 'text': 1}
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_globlist = ['~/programming/*']

" Python PEP8 checker
let g:flake8_show_in_gutter = 1
let g:flake8_quickfix_location = "botright"
let g:flake8_quickfix_height = 6
autocmd BufWritePost *.py call Flake8()

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

" Automatically remove trailing whitespace on save for
" some filetypes
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
