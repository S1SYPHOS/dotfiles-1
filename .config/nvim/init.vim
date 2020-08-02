set shell=/usr/bin/zsh

call plug#begin(expand('~/.config/nvim/plugged'))

" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Plug 'google/vim-glaive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'gosukiwi/vim-atom-dark'
" Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'preservim/nerdcommenter'

call plug#end()

" ignore c/c++ files
set wildignore+=*.o,*.obj,*.out,*.elf,*.exe,*.app

" ignore python files
set wildignore+=*/__pycache__/*,*.pyc

" appearance
set background=dark
" colorscheme atom-dark-256
" colorscheme nord
colorscheme default

" ---- options ----

syntax enable
filetype plugin indent on

set encoding=utf-8

set autochdir
set viminfo
set magic
set showmatch
set autoread

set nobackup
set noswapfile
set nowb
set nowritebackup

set noerrorbells
set noshowmode
set novisualbell

set ignorecase
set smartcase
set expandtab

set smartindent
set smarttab
set softtabstop=0
set tabstop=4
set shiftwidth=2
set autoindent
set cindent
set nojoinspaces
set linebreak
set listchars=eol:¬,space:·,tab:»\
set backspace=indent,eol,start

set laststatus=2
set display+=lastline
set signcolumn=number
set shortmess+=c
set clipboard=unnamedplus
set cmdheight=2
set mat=2

set number
set ruler
set hidden
set cursorline
set wildmenu

set termguicolors
set lazyredraw

set foldenable
set foldlevelstart=10
set foldcolumn=1

set hlsearch
set incsearch
set gdefault

set whichwrap+=<,>,h,l,[,]
set wrap

set updatetime=300
set ttimeout 
set ttimeoutlen=100

" store an undo buffer
set undofile
set undodir=~/.config/nvim/.undo
set undolevels=1000
set undoreload=10000

" fix yaml indentation issues
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" disable auto commenting on next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ---- plugin settings ----

" statusline
let g:lightline = {
      \ 'colorscheme': 'material',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \ },
      \ }

" file tree 
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden=1

" completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" formatting
augroup mygroup
  autocmd!
  autocmd FileType json,yaml,toml,rust,c,go,elixir,python setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup end

" comments
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" ---- key bindings ----

let g:mapleader="\<Space>"

" press Enter to add blank line below current line
map <Enter> o<ESC>

" unbind Ex mode
noremap Q <nop>

" unbind help menues
noremap <F1> <nop>
noremap <S-k> <nop>

" ctrl-n to toggle file tree
map <C-n> :NERDTreeToggle<CR>

" ctrl-backspace to delete last word
imap <C-BS> <C-W>

" map F6 to spellchecking
map <F6> :setlocal spell! spelllang=en_us<CR>

" ctrl-space to trigger completion 
inoremap <silent><expr> <C-space> coc#refresh()

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" highlights the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" apply suggested fix on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')
