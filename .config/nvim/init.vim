"Search options
set ignorecase
set smartcase

colorscheme desert
set background=dark
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

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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
set nofoldenable
set foldmethod=syntax
set foldcolumn=3
nnoremap zZ za
nnoremap zz zR

" Actions when switching to and from terminal
function! s:getExitStatus() abort
  let ln = line('$')
  " The terminal buffer includes several empty lines after the 'Process exited'
  " line that need to be skipped over.
  while ln >= 1
    let l = getline(ln)
    let ln -= 1
    let exitCode = substitute(l, '^\[Process exited \([0-9]\+\)\]$', '\1', '')
    if l != '' && l == exitCode
      " The pattern did not match, and the line was not empty. It looks like
      " there is no process exit message in this buffer.
      break
    elseif exitCode != ''
      return str2nr(exitCode)
    endif
  endwhile
  throw 'Could not determine exit status for buffer, ' . expand('%')
endfunction
function! s:afterTermClose() abort
  if s:getExitStatus() == 0
    bdelete!
  endif
endfunction
augroup terminal
  auto!
  auto TermOpen * startinsert
  auto TermOpen * :call NoInfoCols()
  auto BufEnter,BufWinEnter,WinEnter term://* startinsert
  auto BufEnter,BufWinEnter,WinEnter term://* :call NoInfoCols()
  auto TermClose * call timer_start(20, { -> s:afterTermClose() })
augroup end

" Title
set title
augroup titlebar
  auto!
  auto BufEnter * let &titlestring = hostname() . ":" . expand("%:p")
  auto BufEnter * let &titleold = hostname() . ":" . getcwd()
augroup end

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
set timeoutlen=300 ttimeoutlen=0
let mapleader = ","

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
inoremap <leader><leader> <Esc>
tnoremap <leader><leader> <C-\><C-n>

"Copy-paste modes
set pastetoggle=<F1>
"Pass clipboard through to tmux (see .tmux.conf)
set clipboard=unnamed

nnoremap <silent> <F2> :call ToggleInfoCols()<CR>
augroup bootstrapcols
  auto!
  auto BufReadPost * :call InfoCols()
augroup end
function! ToggleInfoCols()
  if g:infocols
    :call NoInfoCols()
  else
    :call InfoCols()
  endif
endfunction
function! InfoCols()
    let g:infocols=1
    set number
    set relativenumber
    set foldcolumn=3
    :GitGutterEnable
endfunction
function! NoInfoCols()
    let g:infocols=0
    set nonumber
    set norelativenumber
    set foldcolumn=0
    :GitGutterDisable
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
endfunction

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
set grepprg="grep -nH $*"
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

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'HerringtonDarkholme/yats.vim' "typescript syntax
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
  Plug 'sebdah/vim-delve'
endif
call plug#end()

" Default gitgutter update is 4s, make it 100ms
set updatetime=100

let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

let g:ctrlp_working_path_mode = 'ra'

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

let g:javascript_plugin_flow = 1

nnoremap <A-,> :SidewaysLeft<cr>
nnoremap ≤ :SidewaysLeft<cr>
nnoremap <A-.> :SidewaysRight<cr>
nnoremap ≥ :SidewaysRight<cr>

let g:flow#autoclose = 1

hi Search ctermbg=lightred ctermfg=black cterm=none

"Diff mode color customizations
hi DiffAdd     ctermbg=22 guibg=#2E5815
hi DiffDelete  ctermbg=88 guibg=#771C12
hi DiffChange  ctermbg=19 guibg=#0138A7
hi DiffText    ctermbg=NONE guibg=NONE

"Indent guides colors
hi IndentGuidesOdd  ctermbg=grey
hi IndentGuidesEven ctermbg=darkgrey

