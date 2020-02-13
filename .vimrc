" BASIC SETUP

set nocompatible
syntax enable
filetype plugin on

set path+=**
set wildmenu

set tabstop=4
set softtabstop=4
set expandtab

set showcmd

set cursorline
set number

set showmatch

set incsearch
set hlsearch

" TAG JUMPING

" Create the tags file 
" CTRL + ]  go to definition of function/module/...
" g + CTRL + ] list all definitions
" CTRL + T go up tech history
command! MakeTags !ctags -R .

"AUTOCOMPLETE
" CTRL + n for anything specified by the complete option
" CTRL + x + CTRL + f for filenames

"FILE BROWSING
let g:netrw_baner=0

"REMAP ESC KEY
inoremap jj <ESC>


