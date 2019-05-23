"Search options
set ignorecase
set smartcase
set nohlsearch
set incsearch "incsearch.vim highlights all matches, below

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
nnoremap zZ zmzv
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
  return -1
  "throw 'Could not determine exit status for buffer, ' . expand('%')
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
  auto BufEnter * let &titlestring = hostname() . ":" . expand("%")
  auto BufEnter * let &titleold = hostname() . ":" . getcwd()
augroup end

"Show the current command in the lower right corner
set showcmd
set timeoutlen=300 ttimeoutlen=0
let mapleader = ","
nnoremap <silent> <leader>h :let @*=expand('%')<CR>:echo 'copied: '@*<CR>
nnoremap <silent> <leader>H :let @*=expand('%:p')<CR>:echo 'copied: '@*<CR>

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
tnoremap <C-h>	<C-\><C-n><C-w>h
tnoremap <C-l>	<C-\><C-n><C-w>l
tnoremap <C-j>	<C-\><C-n><C-w>j
tnoremap <C-k>	<C-\><C-n><C-w>k
""Resize vertically with shift:
"noremap +		<C-W>+
"noremap _		<C-W>-
""Resize horizontally without shift:
"noremap -		<C-W><
"noremap =		<C-W>>

"Buffer navigation
nnoremap <tab> :b#<cr>
nnoremap <s-tab> :b#<cr>:bd #<cr>

"Reload vimrc
augroup vimrcReload
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup end
command! Rc source ~/.config/nvim/init.vim


" Mode toggling

"Exit insert mode easily
inoremap <leader><leader> <Esc>
nnoremap <leader><leader> <Esc>
vnoremap <leader><leader> <Esc>
tnoremap <leader><leader> <C-\><C-n>

"Copy-paste modes
set pastetoggle=<F1>
"Pass clipboard through to tmux (see .tmux.conf)
set clipboard=unnamed

nnoremap <silent> <F2> :call ToggleInfoCols()<CR>
augroup bootstrapcols
  auto!
  let g:infocols=0
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
    " set relativenumber
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

"Hebrew rtl mode during insert with <C-_>
set allowrevins
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

if ! empty($NEOVIM_PYTHON3_HOST_PROG)
  let g:python3_host_prog = $NEOVIM_PYTHON3_HOST_PROG
endif

call plug#begin('~/.config/nvim/plugged')
" Default gitgutter update is 4s, make it 100ms
set updatetime=100

"Status line:
" %F full file path
" %r read only status, appears as [RO]
" %w preview window flag, appears as [Preview]
" %y file type/syntax language
" %p vertical position as percent of file
" %l/%L line number/total lines
" %v column number
if !exists('g:airline_section_a')
  set statusline=%F%r%w%y[%p%%\ %l/%L,%v]
endif
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline_section_c = '%{airline#extensions#fugitiveline#bufname()}%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline_section_c = ''
"%{airline#util#wrap(airline#extensions#branch#get_head(),120)}'
let g:airline_section_x = ''
let g:airline_section_y = '%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}'
let g:airline_section_z = '%3p%% %4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

let g:sneak#label = 1

" pangloss/vim-javascript highlights on flow syntax
" let g:javascript_plugin_flow = 1

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'cespare/vim-toml'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
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
Plug 'ncm2/ncm2'
Plug 'pangloss/vim-javascript'
Plug 'roxma/nvim-yarp'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'solarnz/thrift.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'udalov/javap-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
  Plug 'sebdah/vim-delve' "go debugger
endif
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
inoremap <leader>e <Esc>:Files<CR>
nnoremap <leader>e :Files<CR>
inoremap <leader>g <Esc>:GFiles<CR>
nnoremap <leader>g :GFiles<CR>
inoremap <leader><leader>a <Esc>:Ag<Space>
nnoremap <leader><leader>a :Ag<Space>
inoremap <leader>b :Buffers<CR>
nnoremap <leader>b :Buffers<CR>
inoremap <leader><leader>g <Esc>:GFiles?<CR>
nnoremap <leader><leader>g :GFiles?<CR>

nnoremap <A-,> :SidewaysLeft<cr>
nnoremap ≤ :SidewaysLeft<cr>
nnoremap <A-.> :SidewaysRight<cr>
nnoremap ≥ :SidewaysRight<cr>

augroup langClient
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_selectionUI = 'fzf'
  let g:LanguageClient_waitOutputTimeout = 60

  let g:LanguageClient_loggingLevel = 'INFO'
  let g:LanguageClient_loggingFile = '/tmp/lsp-client.log'
  let g:LanguageClient_serverStderr = '/tmp/lsp-server.log'

  let g:LanguageClient_rootMarkers = ['pom.xml', 'settings.gradle', 'Cargo.toml', '.git']
  let g:LanguageClient_serverCommands = {}

  if executable('flow')
    let g:LanguageClient_serverCommands.javascript = ['flow', 'lsp']
    auto FileType javascript setlocal omnifunc=LanguageClient#complete
    let g:LanguageClient_serverCommands['javascript.jsx'] = ['flow', 'lsp']
    auto FileType javascript.jsx setlocal omnifunc=LanguageClient#complete
  elseif !exists('g:warnedMissingFlow')
    echo 'Missing language server:'
    echo '  yarn global add flow-bin'
    let g:warnedMissingFlow = 1
  endif

  if executable('rls')
    let g:LanguageClient_serverCommands.rust = ['rls']
    auto FileType rust setlocal omnifunc=LanguageClient#complete
  elseif !exists('g:warnedMissingRustLS')
    echo 'Missing language server:'
    echo '  brew install rustup'
    echo '  rustup-init'
    echo '  rustup component add rls rust-analysis rust-src'
    let g:warnedMissingRustLS = 1
  endif

  if executable('typescript-language-server')
    let g:LanguageClient_serverCommands.typescript = ['typescript-language-server', '--stdio']
    let g:LanguageClient_serverCommands.tsx = ['typescript-language-server', '--stdio']
    auto FileType typescript setlocal omnifunc=LanguageClient#complete
    auto FileType tsx setlocal omnifunc=LanguageClient#complete
  elseif !exists('g:warnedMissingTSLS')
    echo 'Missing language server:'
    echo '  yarn global add typescript-language-server'
    let g:warnedMissingTSLS = 1
  endif

  "has jdt.ls been compiled?
  if filereadable(
        \ $HOME . '/projects/github' .
        \ '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/content.xml')
        " \ '/java-language-server/dist/mac/bin/launcher')
    let g:LanguageClient_serverCommands.java = ['jdtls']
    let g:LanguageClient_serverCommands.jsp = ['jdtls']
    auto FileType java setlocal omnifunc=LanguageClient#complete
    auto FileType jsp setlocal omnifunc=LanguageClient#complete
  elseif !exists('g:warnedMissingJLS')
    echo 'Missing language server:'
    echo '  cd ~/projects/github'
    " echo '  git clone https://github.com/georgewfraser/java-language-server'
    " echo '  cd java-language-server'
    " echo '  JAVA_HOME=$(ls -td /Library/Java/JavaVirtualMachines/*jdk-11.*.*.jdk | head -n1)/Contents/Home \'
    " echo '    scripts/link_mac.sh'
    echo '  git clone https://github.com/eclipse/eclipse.jdt.ls'
    echo '  eclipse.jdt.ls/mvnw clean verify'
  " jdtls already created in ~/local/provide
    let g:warnedMissingJLS = 1
  endif

  if executable('gopls')
    let g:LanguageClient_serverCommands.go = ['gopls']
    auto FileType go setlocal omnifunc=LanguageClient#complete
  elseif !exists('g:warnedMissingGopls')
    echo 'Missing language server:'
    echo '  cd ~/projects/github'
    echo '  git clone -b bingo https://github.com/saibing/tools.git'
    echo '  cd tools/cmd/gopls'
    echo '  go install'
    let g:warnedMissingGopls = 1
  endif

  "all languages
  nnoremap <silent> g<tab> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> g<S-tab> :call LanguageClient_#textDocument_codeAction()<CR>
  nnoremap <silent> g<space> :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> ## :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> #t :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
  "gu = go Usages
  nnoremap <silent> g/ :call LanguageClient#textDocument_references()<CR>
  " nnoremap <silent> ?? :call LanguageClient#textDocument_documentHighlight()<CR>
  " nnoremap <silent> ?? :call LanguageClient#clearDocumentHighlight()<CR>
  nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
  nnoremap <silent> gR :call LanguageClient#workspace_symbol()<CR>
  nnoremap <silent> g[ :call LanguageClient#textDocument_implementation()<CR>
  nnoremap <silent> gqg :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <silent> gs :call LanguageClient#serverStatusMessage()<CR>
  nnoremap <silent> gi :call LanguageClient#debugInfo()<CR>
  " nnoremap <silent> ?? :call LanguageClient#explainErrorAtPoint()<CR>
augroup end

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
