" .VIMRC
set nocompatible
set hidden
set history=1000
set undolevels=1000
set encoding=utf8
set fileencoding=utf8

set cursorline colorcolumn=72,78     " Show rule at 78 char
set cmdheight=1                   " Single-row cmd-line height
set switchbuf=useopen
set showtabline=2                 " Always show tab bar
set winwidth=80
set nonumber numberwidth=5
set smarttab
set scrolloff=5                   " keep more context when scrolling
set shell=bash                    " works better inside tmux
set autoindent                    " indentation
set smartindent
set mouse=a                       " make it easier for others to jump on my machine
set binary noeol                  " don't insert EOL
set showmatch incsearch hlsearch  " search goodness
set ignorecase smartcase          " search case-sensitive if upper-cased
set shortmess=asI                 " remove intro message
set nobackup nowritebackup noswapfile " swap files
set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set showcmd                       " display incomplete commands
set timeout timeoutlen=900 ttimeoutlen=100 " better command timeouts
set tags=./tags;/                 " ctags
set splitbelow splitright         " more natural pane-splitting
set wildmode=longest,list         " use emacs-style tab completion
set wildmenu                      " make tab completion for files/buffers act like bash
set wildignore+=*/tmp/*,*/gems/*,*/node_modules/*,*/dist/*,*/bower_components/*
" set regexpengine=1

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" COLOR & APPERARANCE
"""""""""""""""""""""
syntax on                        " Enable syntax highlighting
set t_Co=256                     " 256 colors
" set g:solarized_termcolors=256
" let g:solarized_termcolors=16
" set background=dark
colorscheme solarized
" colorscheme codeburn



" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|bower_components\|git'
" let g:ctrlp_custom_ignore = '\v[\/](git|node_modules|bower_components)$'
" unlet g:ctrlp_custom_ignore
" let g:ctrlp_custom_ignore = {
"       \ 'dir': '\v[\/](node_modules)$',
"       \ 'file': '\v\.DS_Store',
"       \ }
" let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules|bower_components)$'
let javascript_enable_domhtmlcss=1


" Plugin Crap
" let g:unite_source_history_yank_enable = 1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" nnoremap <C-p> :Unite -start-insert file_rec/async buffer<CR>
" nnoremap <leader>b :Unite -quick-match buffer<cr>
" nnoremap <leader>y :Unite history/yank<cr>
" nnoremap <leader>/ :Unite grep:.<cr>
" if executable('ag')
"   let g:unite_source_grep_command = 'ag'
"   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"   let g:unite_source_grep_recursive_opt = ''
" endif



let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
" let g:airline#extensions#whitespace#enabled = 1

let g:slime_target = "tmux"

" STATUS LINE
"""""""""""""
" left side
" let &stl="\ %<%F\ %([%R%M]%)\ "
" let &stl.="%{fugitive#statusline()}"
" " right side
" let &stl.="%=\ "
" let &stl.="%( %{&filetype} %)|"
" " let &stl.="\ %{&fileformat}\ |"
" " let &stl.="\ %(%{(&fenc!=''?&fenc:&enc)}\ |"
" let &stl.="\ BUF\ #%n\ |"
" let &stl.="\ LN\ %l/%L\ (%p%%)\ |"
" let &stl.="\ COL\ %c%V\ "
set laststatus=2

" CUSTOM BINDINGS
"""""""""""""""""
let mapleader=","                 " map leader to ,

" .VIMRC EDITING
nmap <leader>rce :e $MYVIMRC<CR>
nmap <leader>rcb :e ~/.vimrc.bundles<CR>
nmap <leader>rcr :so $MYVIMRC<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" map <leader>l :silent !reload-chrome<CR>
nnoremap <leader>j :! jshint %<CR>

" OPEN FILES IN DIRECTORY OF CURRENT FILE
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" CHANGE GLOBAL DIRECTORY AND CURRENT DIRECTORY
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>

" Alphabetize with !sort
nnoremap <leader>[az vi{ !sort<CR>
nnoremap <leader>az gv !sort<CR>

" Quick Toggles
nnoremap <leader>w :set invwrap wrap?<CR>
nnoremap <leader>n :set invnumber<CR>
nnoremap <leader>p :set invpaste paste?<CR>

" CTRL
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

map <c-x> <esc>:q<cr>             " easy quit
map <c-t> <esc>:tabnew<cr>        " new tab
nnoremap <leader><leader> <c-^>   " jump to prev buffer
" nnoremap <c-y> "*Y
" vnoremap <c-y> "*y

" show whitespace
" set list
" set listchars=tab:▹▫,trail:▫,extends:◁,nbsp:▫
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set nolist

" AUTOCMDS
""""""""""
augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=80

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "list listchars=tab:▹▫,trail:▫,extends:◁,nbsp:▫
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,json,sass,vim,clojure set ai sw=2 sts=2 et
  autocmd FileType python,c,make      set ai sw=4 sts=4 et
  autocmd FileType go                 set ai sw=4 sts=4 ts=4 noet
  " autocmd FileType md, mkd, markdown  setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd CmdwinEnter * :unmap <cr>
  autocmd CmdwinLeave * :call MapCR()
augroup END

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc.bundles so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" FUNCTIONS
"""""""""""
" Clear The Search Buffer When Hitting Return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Multipurpose Tab Key
" Indent if we're at the beginning of a line. Else do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Rename Current File
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>rn :call RenameFile()<cr>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor  " Use Ag over Grep
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

set hidden