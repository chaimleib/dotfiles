set nocompatible    "disable vi compatibility; unleash the POWER!

"Search options
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set t_Co=256        "tell vim that we have a 256-color terminal
set background=dark
colorscheme desert
set scrolloff=2
set wildmenu
set wildmode=list:longest

"Indent handling
set autoindent
set smartindent
set tabstop=2       "tabs 2 spaces wide
set softtabstop=2   "delete whole tabs at a time
set shiftwidth=2    "indent 2 spaces wide
set expandtab       "soft tabs
filetype plugin indent on

" Don't remove leading space in the line
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
set backspace=indent,eol,start

" Folding
set foldlevelstart=0
set foldmethod=syntax
set foldcolumn=3
nmap zZ za
nmap zz zR

" Title
set title
auto BufEnter * let &titlestring = hostname() . ":" . expand("%:p")
auto BufEnter * let &titleold = hostname() . ":" . getcwd()

set ruler
set number

set laststatus=2
"Status line:
" %F full file path
" %r read only status, appears as [RO]
" %w preview window flag, appears as [Preview]
" %y file type/syntax language
" %p vertical position as percent of file
" %l/%L line number/total lines
" %v column number
set statusline=%F%r%w%y[%p%%\ %l/%L,%v]

"Show the current command in the lower right corner
set showcmd

" #### Key mappings ####
"Break the arrow key habit
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"
""Break the hjkl anti-patterns
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>

"Move by display lines
map <A-j>	gj
map <A-k>	gk
map <A-h>	g0
map <A-l>	g$

"Split view manipulation
map <C-h>	<C-W>h
map <C-l>	<C-W>l
map <C-j>	<C-W>j
map <C-k>	<C-W>k
"Resize vertically with shift:
map +		<C-W>+
map _		<C-W>-
"Resize horizontally without shift:
map -		<C-W><
map =		<C-W>>

" Mode toggling

"Exit insert mode easily
imap ,, <Esc>

"Copy-paste modes
set pastetoggle=<F1>

nmap <silent> <F2> :call ToggleInfoCols()<CR>
let infocols=1
function! ToggleInfoCols()
    if g:infocols
        let g:infocols=0
        set nonumber
        set foldcolumn=0
    else
        let g:infocols=1
        set number
        set foldcolumn=3
    endif
endfunction

imap <F3> <c-o>:call ToggleHebrew()<CR>
nmap <F3> :call ToggleHebrew()<CR>
function! ToggleHebrew()
    if &rl
        set norl
        set keymap=
    else
        set rl
        set keymap=hebrew
    end
endfunc

"Show syntax highlighting group name
map <F10> :echo "hi<"
\ . synIDattr(synID(line("."),col("."),1),"name")
\ . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name")
\ . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
\ . ">"<CR>


"XML tidying
"Disabled, since it could not tidy large, multi-megabyte files
"map ,x :silent 1,$!xmllint --format --maxmem 1000000000 --recover - 2>/dev/null <CR>

set backupskip=/tmp/*,/private/tmp/*
" Used by CommandT - ignores files and directories when fuzzy finding
set wildignore+=*.log,*.xml,doc/**

"Makes vim invoke latex-suite when a .tex file is opened.
filetype plugin on
set shellslash
set grepprg="grep -nH $*"
let g:tex_flavor='latex'

syntax on

autocmd Syntax python setlocal foldmethod=indent
autocmd Syntax python setlocal tabstop=4
autocmd Syntax python setlocal softtabstop=4
autocmd Syntax python setlocal shiftwidth=4
let g:pep8_map = ':pep'


autocmd Syntax sh setlocal tabstop=4
autocmd Syntax sh setlocal softtabstop=4
autocmd Syntax sh setlocal shiftwidth=4

autocmd Syntax makefile setlocal tabstop=4
autocmd Syntax makefile setlocal softtabstop=4
autocmd Syntax makefile setlocal shiftwidth=4

" Set ruby-style 2-space indents
autocmd Syntax ruby setlocal tabstop=2
autocmd Syntax ruby setlocal softtabstop=2
autocmd Syntax ruby setlocal shiftwidth=2

autocmd Syntax haml setlocal tabstop=2
autocmd Syntax haml setlocal softtabstop=2
autocmd Syntax haml setlocal shiftwidth=2

hi Search ctermbg=lightred ctermfg=black cterm=none

execute pathogen#infect()
filetype plugin indent on

