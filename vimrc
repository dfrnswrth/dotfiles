" .VIMRC
let mapleader=","                 " map leader to ,

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set nobackup nowritebackup noswapfile   " swap files
set history=1000                  " lots of history
set undolevels=1000               " lots of undo
set showcmd                       " display incomplete commands
set showmatch incsearch hlsearch  " search goodness
set laststatus=2                  " always show status
set autowrite                     " write before running commands
set hidden                        " keep buffers around
set encoding=utf8                 " utf-8 just about everything
set fileencoding=utf8             " ditto

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" AUTOCMDS
""""""""""
augroup vimrcEx
  autocmd!
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
  autocmd FileType text setlocal textwidth=80
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType md, mkd, markdown  setlocal spell

  autocmd FileType ruby,haml,eruby,yaml,html,javascript,json,sass,vim,clojure set ai sw=2 sts=2 et
  autocmd FileType python,c           set ai sw=4 sts=4 et
  autocmd FileType go,make            set ai sw=4 sts=4 ts=4 noet
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd CmdwinEnter * :unmap <cr>
  autocmd CmdwinLeave * :call MapCR()
augroup END

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vimrc.bundles so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" COLOR & APPERARANCE
"""""""""""""""""""""
syntax on                        " Enable syntax highlighting
set t_Co=256                     " 256 colors
colorscheme solarized
set background=light

" MORE SETTINGS
"""""""""""""""
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set nolist
set textwidth=80
set colorcolumn=80,+0								" show col at textwidth and 80
set cursorline                    " highlight current line
set cmdheight=1                   " Single-row cmd-line height
set switchbuf=useopen
set showtabline=2                 " Always show tab bar
set winwidth=80
set nonumber numberwidth=5
set smarttab
set scrolloff=5                   " keep more context when scrolling
set shell=bash                    " works better inside tmux
set autoindent smartindent        " indentation
set mouse=a                       " make it easier for others to jump on my machine
set binary noeol                  " don't insert EOL
set ignorecase smartcase          " search case-sensitive if upper-cased
set shortmess=asI                 " remove intro message
set timeout timeoutlen=900 ttimeoutlen=100 " better command timeouts
set tags=./tags;/                 " ctags
set splitbelow splitright         " more natural pane-splitting
set wildmode=longest,list         " use emacs-style tab completion
set wildmenu                      " make tab completion for files/buffers act like bash
set wildignore+=*/tmp/*,*/gems/*,*/node_modules/*,*/dist/*,*/bower_components/*,*.pyc
set cole=1                                " set conceal level

" PLUGIN SETTINGS
"""""""""""""""""
" nnoremap <C-p> :Unite file_rec/async<cr>
" nnoremap <leader>/ :Unite grep:.<cr>
" let g:unite_source_history_yank_enable = 1
" let g:unite_enable_start_insert = 1
" nnoremap <leader>y :Unite history/yank<cr>

let g:netrw_list_hide='.*\.swp$,.*\.pyc$'

let g:javascript_enable_domhtmlcss = 1    " helps with jsx
" let g:javascript_conceal_function  = "ƒ"  " hide 'function'

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#whitespace#enabled = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" let g:vimfiler_as_default_explorer = 1

" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }
"
" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
"
" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" " Close popup by <Space>.
" "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
" " For cursor moving in insert mode(Not recommended)
" "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
" "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
" "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
" "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" " Or set this.
" "let g:neocomplete#enable_cursor_hold_i = 1
" " Or set this.
" "let g:neocomplete#enable_insert_char_pre = 1
"
" " AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1
"
" " Shell like behavior(not recommended).
" "set completeopt+=longest
" "let g:neocomplete#enable_auto_select = 1
" "let g:neocomplete#disable_auto_complete = 1
" "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
" "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"
" let g:UltiSnipsExpandTrigger="<tab>"
" " let g:UltiSnipsJumpForwardTrigger="<tab>"
" " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" CUSTOM BINDINGS
"""""""""""""""""

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
nnoremap <leader>j :! eslint %<CR>

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

map <c-x> <esc>:q<cr>             " easy quit
map <c-t> <esc>:tabnew<cr>        " new tab
nnoremap <leader><leader> <c-^>   " jump to prev buffer

" fat arrow = <c-l>
imap <c-l> <space>=><space>

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
