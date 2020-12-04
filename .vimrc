set nocompatible    "disable vi compatibility; unleash the POWER!

"Search options
set showmatch
set ignorecase
set smartcase
set nohlsearch
set incsearch "incsearch.vim highlights all matches, below

colorscheme desert
set background=dark
set t_Co=256        "tell vim that we have a 256-color terminal
syntax on
set scrolloff=2
set mouse=a
set wildmode=list:longest,full
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=*.log,*.xml,doc/**
set wildignore+=*.class
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=node_modules/*,bower_components/*,*/.git/**

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
set backspace=indent,eol,start

" Folding
set foldmethod=syntax
"set nofoldenable
set foldlevelstart=5
nnoremap zZ zmzv
nnoremap zz zR

" Title
set title
augroup titlebar
  auto!
  auto BufEnter * let &titlestring = hostname() . ":" . expand("%")
  auto BufEnter * let &titleold = hostname() . ":" . getcwd()
augroup end

"Show the current command in the lower right corner
set showcmd
set timeoutlen=300 ttimeoutlen=0
let mapleader = ","
nnoremap <silent> <leader>h :let @"=expand('%')<CR>:echo 'copied: '@"<CR>
nnoremap <silent> <leader>H :let @"=expand('%:p')<CR>:echo 'copied: '@"<CR>

"Borrowing some shortcuts from macOS
inoremap <silent> <M-BS> <Esc><Space>cb

"Move by display lines
noremap <A-j>	gj
noremap ∆ gj
noremap <A-k>	gk
noremap ˚ gk
noremap <A-h>	g0
noremap ˙ g0
noremap <A-l>	g$
noremap ¬ g$

"Split view manipulation
inoremap <C-h>	<C-\><C-n><C-w>h
inoremap <C-l>	<C-\><C-n><C-w>l
inoremap <C-j>	<C-\><C-n><C-w>j
inoremap <C-k>	<C-\><C-n><C-w>k
nnoremap <C-h>	<C-w>h
nnoremap <C-l>	<C-w>l
nnoremap <C-j>	<C-w>j
nnoremap <C-k>	<C-w>k
"Resize vertically with shift:
noremap +		<C-W>+
noremap _		<C-W>-
"Resize horizontally without shift:
noremap -		<C-W><
noremap =		<C-W>>

"Buffer navigation
nnoremap <tab> :b#<cr>
nnoremap <s-tab> :b#<cr>:bd #<cr>

"Reload vimrc
augroup vimrcReloadOnSave
  au!
  if has('nvim')
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim  "if current nvim has vimrc
    command! Rc source ~/.config/nvim/init.vim  "in other nvim instances, with  :Rc
  else
    autocmd bufwritepost .vimrc source ~/.vimrc
    command! Rc source ~/.vimrc
  endif
augroup end

" Mode toggling

"Exit insert mode easily
inoremap <leader><leader> <Esc>
nnoremap <leader><leader> <Esc>
vnoremap <leader><leader> <Esc>

"Copy-paste modes
set pastetoggle=<F1>
"Pass clipboard through to tmux (see .tmux.conf)
set clipboard=unnamed

nnoremap <silent> <F2> :call ToggleInfoCols()<CR>
let infocols=1
set number
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

"Hebrew rtl mode during insert with <C-_>
" set allowrevins
" inoremap <F3> <c-o>:call ToggleHebrew()<CR>
" nnoremap <F3> :call ToggleHebrew()<CR>
" function! ToggleHebrew()
"   if &rl
"     set norl
"     set keymap=
"   else
"     set rl
"     set keymap=hebrew
"   end
" endfunction

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
"map <leader>x :silent 1,$!xmllint --format --maxmem 1000000000 --recover - 2>/dev/null <CR>

set backupskip=/tmp/*,/private/tmp/*

"Makes vim invoke latex-suite when a .tex file is opened.
filetype plugin on
set shellslash
set grepprg="rg --vimgrep"
let g:tex_flavor='latex'

"Python style settings
let g:pep8_map = ':pep'

augroup inittabs
  auto!
  auto BufNewFile,BufRead *.js.flow set syntax=javascript
  auto Filetype python   setlocal tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent
  auto Filetype sh       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  auto Filetype makefile setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  auto Filetype ruby     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  auto Filetype haml     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  filetype plugin indent on
augroup end

auto BufNewFile,BufRead *.neomuttrc set syntax=neomuttrc
auto BufNewFile,BufRead *.muttrc set syntax=muttrc

augroup xml
  auto!
  auto FileType html,xhtml,xml let g:xml_syntax_folding=1
  auto FileType html,xhtml,xml setlocal foldmethod=syntax
  auto FileType html,xhtml,xml :syntax on
  auto FileType html,xhtml,xml :%foldopen!
augroup end

" Default gitgutter update is 4s, make it 100ms
set updatetime=100

set ruler
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
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2


call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'cespare/vim-toml'
Plug 'easymotion/vim-easymotion'
if has('patch-7-4-2009')
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
end
Plug 'FooSoft/vim-argwrap'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'HerringtonDarkholme/yats.vim' "typescript syntax
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'maralla/vim-toml-enhance'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mxw/vim-jsx' "combo with pangloss/vim-javascript
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" easymotion/incsearch
nmap <leader>f <Plug>(easymotion-bd-f)
vmap <leader>f <Plug>(easymotion-bd-f)

function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
    \ 'keymap': {
    \   "\<CR>": '<Over>(easymotion)'
    \ },
    \ 'is_expr': 0
    \ }), get(a:, 1, {}))
    endfunction

noremap ?/  <Plug>(incsearch-stay)
noremap //  <Plug>(incsearch-easymotion-/)
noremap ??  <Plug>(incsearch-easymotion-?)
noremap /?  <Plug>(incsearch-easymotion-stay)

" fzf
let g:fzf_command_prefix = 'Fzf'
inoremap <leader>e <Esc>:FzfFiles<CR>
nnoremap <leader>e :FzfFiles<CR>
inoremap <leader>E <Esc>:FzfFiles?<CR>
nnoremap <leader>E :FzfFiles?<CR>
inoremap <leader>g <Esc>:FzfGFiles<CR>
nnoremap <leader>g :FzfGFiles<CR>
inoremap <leader>r <Esc>:FzfRg<Space>
nnoremap <leader>r :FzfRg<Space>
inoremap <leader>b :FzfBuffers<CR>
nnoremap <leader>b :FzfBuffers<CR>
inoremap <leader><leader>g <Esc>:FzfGFiles?<CR>
nnoremap <leader><leader>g :FzfGFiles?<CR>


nnoremap <A-,> :SidewaysLeft<cr>
nnoremap ≤ :SidewaysLeft<cr>
nnoremap <A-.> :SidewaysRight<cr>
nnoremap ≥ :SidewaysRight<cr>

let g:flow#autoclose = 1


hi Search ctermbg=lightred ctermfg=black cterm=none

"Diff mode color customizations
hi DiffAdd     ctermbg=22 guibg=#2E5815
hi DiffDelete  ctermbg=88 guibg=#771C12
hi DiffChange  ctermbg=22 guibg=#2E5815
hi DiffText    ctermbg=28 guibg=#50A31F

"Indent guides colors
hi IndentGuidesOdd  ctermbg=236
hi IndentGuidesEven ctermbg=234

"Current line
set cursorline
hi CursorLine term=NONE cterm=NONE ctermbg=236 guibg=Grey30

"Trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
