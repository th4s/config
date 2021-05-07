" IMPORTANT: Make sure to install the rust tools 'bat' and 'ripgrep' and enter
" :PlugInstall on your first execution
"
"""""""""""""""""
""""" BASIC SETUP 
"""""""""""""""""

" Do not start in compatible vi mode
set nocompatible

" Set color scheme
colorscheme industry

" Create backup, swap and undo directories if they do not exist
" Backup files are copies of the last saved version of a file
" Swap files contain the current modification of a file
" Undo files let you use the undo command after closing and reopening vim

silent !mkdir -p /tmp/vim/backup
silent !mkdir -p /tmp/vim/swap
silent !mkdir -p /tmp/vim/undo

" Create a .vim folder in home dir
silent !mkdir -p ~/.vim

set backupdir=/tmp/vim/backup
set dir=/tmp/vim/swap
set undodir=/tmp/vim/undo
" Create undo files
set undofile

" Map capslock to ctrl
silent !setxkbmap -option caps:ctrl_modifier

" Add syntx highlightning
syntax on

" No error bells
set noerrorbells

" Set length of tab
set tabstop=4 softtabstop=4

" Set number of spaces for each step of indent
set shiftwidth=4

" Use spaces instead of tab character
set expandtab

" Use smart indent 
set smartindent

" Use line numbering
set nu

" Also use relative line numbering
set relativenumber

" Do not use word wrap
set nowrap

" Use incremental search, i.e. highlight search results while typing
set incsearch

" If we open a project folder with 'vim .' and there is a .vimrc present, then
" use this as a config file. This allows project specific config files
set exrc

" When finishing search mode we do not want to keep search results highlighted
set nohlsearch

" Start scrolling x lines before the current line reaches the end of the screen
set scrolloff=8

" Keep buffers of multiple files in memory so that you can open a new file without saving the current one
set hidden

"""""""""""""""
" BASIC MAPPING
"""""""""""""""

" Escape every mode more simple by mapping Ctrl + J to Escape
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

" Set space to leader
let mapleader = " "

" We do not want to use arrow keys for navigation
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" We want to go back and forth in buffers easily and simplify closing them
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
nnoremap <leader>c :bd<CR>

" Toggle between current and recent buffer
nnoremap <leader><leader> <C-^>

" Suspend vim with shortcut (move process to background and then type 'fg' to return to vim)
inoremap <C-k> :sus<CR>
vnoremap <C-k> :sus<CR>
nnoremap <C-k> :sus<CR>

" Show current open buffers
nnoremap <leader>, :ls<CR>

" Quick save
nnoremap <C-w> :w<CR>

" Quick window mode
nnoremap <leader>w <C-w>


"""""""""""""""
""""""" PLUGINS
"""""""""""""""

" We use 'vim-plug' as a plugin manager. The following code automates the installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Now we add the plugins we want to use
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' 
call plug#end()

" Use shortcut for fuzzy finding files by name
nnoremap <silent> <leader>o :GFiles --cached --others --exclude-standard<CR>

" Use shorcut for fuzzy searching for expression in all subdirectories
nnoremap <silent> <leader>f :Rg<CR>
