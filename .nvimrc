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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'

Plug 'hynek/vim-python-pep8-indent'
Plug 'ivan-krukov/vim-snakemake'
Plug 'broadinstitute/vim-wdl'

Plug 'rust-lang/rust.vim'
Plug 'eagletmt/neco-ghc'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
Plug 'nickhutchinson/vim-cmake-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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
set textwidth=120
set formatoptions+=1r
set colorcolumn=120
set ttimeoutlen=50

" Recursive lookup for tags file
set tags=./tags;/

" Open all folds by default
au BufWinEnter * normal zR

" Enable wildmenu, laststatus=2 also required for powerline
set laststatus=2
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc,*.a,*.d


" CoC autocompletion settings
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Make sure COC-python finds the right python
if $CONDA_PREFIX == ""
  let s:current_python_path=split(execute('!which python3'), '\n')[-1]
else
  let s:current_python_path=$CONDA_PREFIX.'/bin/python'
endif
call coc#config('python', {'pythonPath': s:current_python_path})

" Use tab for trigger completion with characters ahead and navigate.
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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

autocmd FileType c,cpp,java,php,ruby,python,snakemake autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Snakemake support
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red 
