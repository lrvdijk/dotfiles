"
" Plugin Management
" =================
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/bundle')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-completer' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'

Plug 'hynek/vim-python-pep8-indent'
Plug 'https://bitbucket.org/snakemake/snakemake.git', {'rtp': 'misc/vim/'}
Plug 'broadinstitute/vim-wdl'

Plug 'rust-lang/rust.vim'
Plug 'tkztmk/vim-vala'
Plug 'eagletmt/neco-ghc'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
Plug 'nickhutchinson/vim-cmake-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'neomake/neomake'

Plug 'plasticboy/vim-markdown'
Plug 'greyblake/vim-preview'
Plug 'majutsushi/tagbar'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" Make sure to use python3
" let g:python3_host_prog = 'python3'

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
let python_highlight_all=1
syntax on
set background=dark

" Base16 colourscheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-default-dark

" Vim Airline configuration
let g:airline_powerline_fonts=1

" Misc settings
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set autoindent
set textwidth=80
set formatoptions+=1r
set colorcolumn=80
set ttimeoutlen=50

" Recursive lookup for tags file
set tags=./tags;/

" Open all folds by default
au BufWinEnter * normal zR

" Enable wildmenu, laststatus=2 also required for powerline
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d

" YouCompleteMe Settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_globlist = ['~/Stack/*','~/BroadDrive/*','~/programming/*','!~/*']

" Let YouCompleteMe also suggest LaTeX completions from VimTex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
        \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
        \ 're!\\hyperref\[[^]]*',
        \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(include(only)?|input){[^}]*',
        \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
        \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
\ ]

" Run neomake on save
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_list_height = 5
let g:neomake_cpp_enabled_makers = []
let g:neomake_python_enabled_makers = ['flake8']

" vim-pandoc settings
" Disable folding
let g:pandoc#modules#disabled = ["folding"]
" Enable hard line breaks
let g:pandoc#formatting#mode = "ha"

" Rust.vim automatic formatting
let g:rustfmt_autosave = 1

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

" Workaround for neovim Ctrl+h issue
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" Highlight current line when in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Tagbar keymap
nmap <leader>s :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" Automatically remove trailing whitespace on save for
" some filetypes
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Snakemake support
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red 
