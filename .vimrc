" IMPORTANT: Make sure to install the rust tools 'bat', 'ripgrep'
" 'rust_analyzer', 'rust-src'
" :PlugInstall on your first execution
"
"""""""""""""""""
""""" BASIC SETUP 
"""""""""""""""""

" Do not start in compatible vi mode
set nocompatible

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

" Add syntx highlightning an file type identification, plugin and indenting
syntax on
filetype plugin indent on

" Add a permanent sign column so that columns does not disappear and reappear
" during diagnostic
set signcolumn=yes


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

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Some improvements for brackets and so on 
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> > strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

fun! MyCR()
    if strpart(getline('.'), col('.') - 2, 2) == '{}'
        return "\<CR>\<CR>\<Up>\<Tab>"
    endif
    return "\<CR>"
endfun
autocmd FileType * inoremap <CR> <C-R>=MyCR()<CR>
""
"""""""""""""""
""""""" PLUGINS
"""""""""""""""

" We use 'vim-plug' as a plugin manager. The following code automates the installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Now we add the plugins we want to use
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' 
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
if has('nvim')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
endif
call plug#end()

" When we lookup files in a directory we want to respect the .gitignore file,
" but if we are not in a git repository we want to list all files
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles --cached --others --exclude-standard\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

" Use shortcut for fuzzy finding files by name
nnoremap <silent> <leader>o :call GFilesFallback()<CR>

" Use shorcut for fuzzy searching for expression in all subdirectories
nnoremap <silent> <leader>f :Rg<CR>

" Set colorscheme
colorscheme onedark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Configure lightline to use one-dark color-scheme
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

if has('nvim')
" Setup rust_analyzer as nvim language server
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF

" Auto fmt .rs files before saving
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

"Autocomplete config
set completeopt=menuone,noselect,noinsert

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

" Now we map some hotkeys for code navigation
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
endif
