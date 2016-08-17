"Search options
set ignorecase
set smartcase

set background=dark
colorscheme desert
set scrolloff=2
set wildmode=list:longest

"Indent handling
set smartindent
set tabstop=2       "tabs 2 spaces wide
set softtabstop=2   "delete whole tabs at a time
set shiftwidth=2    "indent 2 spaces wide
set expandtab       "soft tabs

" Don't remove leading space in the line
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" Folding
set foldlevelstart=0
set foldmethod=syntax
set foldcolumn=3
nnoremap zZ za
nnoremap zz zR

" Title
set title
auto BufEnter * let &titlestring = hostname() . ":" . expand("%:p")
auto BufEnter * let &titleold = hostname() . ":" . getcwd()

set ruler
set number

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
noremap <A-j>	gj
noremap <A-k>	gk
noremap <A-h>	g0
noremap <A-l>	g$

"Split view manipulation
inoremap <C-h>	<C-w>h
inoremap <C-l>	<C-w>l
inoremap <C-j>	<C-w>j
inoremap <C-k>	<C-w>k
nnoremap <C-h>	<C-w>h
nnoremap <C-l>	<C-w>l
nnoremap <C-j>	<C-w>j
nnoremap <C-k>	<C-w>k
tnoremap <C-h>	<C-\><C-n><C-w>h
tnoremap <C-l>	<C-\><C-n><C-w>l
tnoremap <C-j>	<C-\><C-n><C-w>j
tnoremap <C-k>	<C-\><C-n><C-w>k
"Resize vertically with shift:
noremap +		<C-W>+
noremap _		<C-W>-
"Resize horizontally without shift:
noremap -		<C-W><
noremap =		<C-W>>

" Mode toggling

"Exit insert mode easily
inoremap ,, <Esc>
tnoremap ,, <C-\><C-n>

"Copy-paste modes
set pastetoggle=<F1>

nnoremap <silent> <F2> :call ToggleInfoCols()<CR>
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

inoremap <F3> <c-o>:call ToggleHebrew()<CR>
nnoremap <F3> :call ToggleHebrew()<CR>
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
noremap <F10> :echo "hi<"
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

filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
