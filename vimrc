" .VIMRC
" vim:set ts=2 sts=2 sw=2 expandtab:
set nocompatible
set hidden
set history=1000

set encoding=utf8
set fileencoding=utf8

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" COLOR & APPERARANCE
"""""""""""""""""""""
set t_Co=256 " 256 colors
let g:codeburn_high_contrast = 0
colors codeburn

let g:vitality_fix_cursor = 0

" highlight current line
" set cursorline
" set colorcolumn=78
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=80
" set number
" set numberwidth=5
set undolevels=1000
set smarttab

" remove intro message
set shortmess=asI

" STATUS LINE
" left side
let &stl="\ %<%F\ %([%R%M]%)\ "
let &stl.="%{fugitive#statusline()}"
" right side
let &stl.="%=\ "
let &stl.="%( %{&filetype} %)|"
let &stl.="\ %{&fileformat}\ |"
let &stl.="\ %(%{(&fenc!=''?&fenc:&enc)}\ |"
let &stl.="\ BUF\ #%n\ |"
let &stl.="\ LN\ %l/%L\ (%p%%)\ |"
let &stl.="\ COL\ %c%V\ "

set laststatus=2

" keep more context when scrolling off the end of a buffer
set scrolloff=5
set shell=bash

" CUSTOM BINDINGS
"""""""""""""""""
" map leader to ,
let mapleader=","

" auto-indent-return
inoremap <c-cr> <cr><esc>O<cr>

" CTRL
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" emacs-like line home-end bindings
map <c-e> <c-o>$
imap <c-a> <c-o>^

" easy quit
map <c-x> <esc>:q<cr>

" easy esc
map <c-c> f<esc>

" new tab
map <c-t> <esc>:tabnew<cr>

" LEADER
" JUMP TO PREV BUFFER
nnoremap <leader><leader> <c-^>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

map <Leader>l :silent !reload-chrome<CR>

" .VIMRC EDITING
nmap <leader>rce :e $MYVIMRC<CR>
nmap <leader>rcb :e ~/.vimrc.bundles<CR>
nmap <leader>rcr :so $MYVIMRC<CR>

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

" RENAME CURRENT FILE
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

set wildignore+=*/tmp/*,*/gems/*,*/node_modules/*,*/dist/*

" indentation
set autoindent

" make it easier for others to jump on my machine
set mouse=a

" don't insert EOL
set binary
set noeol

" search goodness
set showmatch
set incsearch
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" dynamic window sizing
" set winheight=5     " set small height first
" set winminheight=5  " now set min height
" set winheight=999   " set large height for dynamic sizing

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" SWAP FILES
""""""""""""
set nobackup
set nowritebackup
set noswapfile

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" display incomplete commands
set showcmd

" Enable syntax highlighting
syntax on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu

" show hidden
let g:ctrlp_show_hidden = 1
set timeout timeoutlen=900 ttimeoutlen=100


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

  " autocmd FileType ruby,haml,eruby,yaml,html,javascript,json,php,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set ai sw=4 sts=4 et
  autocmd FileType c set ai sw=4 sts=4 et
  autocmd FileType make set ai sw=4 sts=4 ts=4 noet list! listchars=trail:▫,extends:◁,nbsp:▫

  autocmd FileType go set ai sw=4 sts=4 ts=4 noet list! listchars=trail:▫,extends:◁,nbsp:▫

  " autocmd FileType vim set ai sw=2 sts=2 et

  " Don't syntax highlight markdown because it's often wrong
  autocmd FileType md, mkd, markdown  setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd CmdwinEnter * :unmap <cr>
  autocmd CmdwinLeave * :call MapCR()
augroup END

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" show whitespace
set list
set listchars=tab:▹▫,trail:▫,extends:◁,nbsp:▫

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap


" CLEAR THE SEARCH BUFFER WHEN HITTING RETURN
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" MULTIPURPOSE TAB KEY
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

" MISC
" ctags
set tags=./tags;/

set splitbelow
set splitright

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

nnoremap <c-y> "*Y
vnoremap <c-y> "*y

nnoremap <leader>j :! jshint %<CR>
" nnoremap <leader>n :NERDTree<CR>