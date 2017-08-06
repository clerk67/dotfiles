" Configuration file for vim
" set modelines=0   " CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
" set nocompatible  " Use Vim defaults instead of 100% vi compatibility
" set backspace=2   " more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
" au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
" au BufWrite /private/etc/pw.* set nowritebackup nobackup

if &compatible
  set nocompatible  " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.vim')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('cohama/agit.vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('haya14busa/incsearch.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('itmammoth/doorboy.vim')
call dein#add('jaxbot/github-issues.vim')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-textobj-user')
call dein#add('kannokanno/previm')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('mattn/emmet-vim')
call dein#add('mattn/gist-vim')
call dein#add('mattn/vim-prompter')
call dein#add('mattn/webapi-vim')
call dein#add('rhysd/github-complete.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-surround')
call dein#add('tyru/open-browser.vim')
call dein#add('tyru/open-browser-github.vim')

if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
else
  call dein#add('Shougo/neocomplete.vim')
endif

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

set autoindent
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noshowmode
set number
set shiftwidth=4
set showtabline=2
set smartcase
set smartindent
set softtabstop=4
set spelllang=en,cjk
set tabstop=4

inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap {<Enter> {}<Left><CR><Esc><S-o>
inoremap (<Enter> ()<Left><CR><Esc><S-o>
inoremap [<Enter> []<Left><CR><Esc><S-o>
nnoremap <Esc><Esc> :nohlsearch<CR>

augroup ftindent
  autocmd!
  autocmd BufNewFile,BufRead *.html,*.css,*.js,*.jsx,*.rb,*.sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup myXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

autocmd FileType php :set dictionary=$HOME/.vim/dict/php.dict

runtime ftplugin/man.vim

colorscheme molokai
syntax on

" dhruvasagar/vim-table-mode
let g:table_mode_corner = '|'

" itchyny/lightline.vim
let g:lightline = {
  \   'colorscheme': 'default',
  \   'mode_map': {
  \     'c': 'NORMAL',
  \   },
  \   'active': {
  \     'left': [['mode', 'paste'], ['fugitive', 'filename']],
  \   },
  \   'component_function': {
  \     'modified': 'LightlineModified',
  \     'readonly': 'LightlineReadonly',
  \     'fugitive': 'LightlineFugitive',
  \     'filename': 'LightlineFilename',
  \     'fileformat': 'LightlineFileformat',
  \     'filetype': 'LightlineFiletype',
  \     'fileencoding': 'LightlineFileencoding',
  \     'mode': 'LightlineMode',
  \   },
  \   'separator': {
  \     'left': '',
  \     'right': '',
  \   },
  \   'subseparator': {
  \     'left': '',
  \     'right': '',
  \   },
  \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' ' . branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" nathanaelkane/vim-indent-guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'man', 'nerdtree']
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=237

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \   'default': '',
  \   'vimshell': $HOME . '/.vimshell_hist',
  \   'scheme': $HOME . '/.gosh_completions',
  \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "") . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Shell like behavior (not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Plugin key-mappings.
" Note: It must be "imap" and "smap". It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap". It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB>
  \ pumvisible() ? "\<C-n>" :
  \ neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Set snippets directory.
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

