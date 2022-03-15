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
silent !mkdir -p /tmp/vim/preview

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
set scrolloff=5

" Keep buffers of multiple files in memory so that you can open a new file without saving the current one
set hidden

" We do not want vimdiff to open in read only mode
set noro


"""""""""""""""
" BASIC MAPPING
"""""""""""""""

" Disable weird modes like command history and ex mode
nnoremap q: <nop>
nnoremap Q <nop>

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
inoremap <C-k> <C-o>:sus<CR>
vnoremap <C-k> :sus<CR>
nnoremap <C-k> :sus<CR>

" Show current open buffers
nnoremap <leader>, :ls<CR>

" Quick save
nnoremap <C-w> :w<CR>
inoremap <C-w> <C-o>:w<CR>

" Quick window mode
nnoremap <leader>w <C-w>

" Create new tab and close tab
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Movement of characters in line 
nnoremap <S-l> xp
nnoremap <S-h> xhhp

" Sometimes, we do not want to fill registers automatically, i.e. we want to
" delete something `d` without putting it in a register so that it
" does not show up when we press `p` afterwards
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Do not yank selected lines when using put in visual mode
vnoremap p "_dP

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Some improvements for brackets and so on 
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "\`" ? "\<Right>" : "\`\`\<Left>"

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> > strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

" This is our improved return to make correct indentation in '{' and '}'
" brackets
fun! SuperCR()
    if strpart(getline('.'), col('.') - 2, 2) == '{}'
        return "\<CR>\<ESC>\O"
    endif
    return "\<CR>"
endfun
autocmd FileType * inoremap <CR> <C-R>=SuperCR()<CR>

" Quickly navigate to an open tab with leader key and number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt

" Use spellchecking and add toggle button
set spelllang=en
nnoremap <silent> <F12> :set spell!<cr>
inoremap <silent> <F12> <C-O>:set spell!<cr>

" We want to compile markdown files to pdf when we save them
" We also add a :preview command and map it to F9
autocmd BufWritePost *.md :silent !pandoc <afile>:p -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=gray -o /tmp/vim/preview/<afile>:t:r.pdf
command Preview !xdg-open /tmp/vim/preview/%:t:r.pdf
map <F9> :Preview<CR><CR>

"Format file
nnoremap <F5> gg=G<C-O>

""""""""""""""""""
""""""""" EXPLORER
""""""""""""""""""
if has('vim')

"""" NETRW setting
" Disable the banner
let g:netrw_banner=0

" Make tee view default
let g:netrw_liststyle = 3

" When opening a new file, open it in a large vsplit on the right
let g:netrw_altv = 1

" Set netrw window size
let g:netrw_winsize = 20

" Show preview window in vertical split
let g:netrw_preview = 1

" Create hotkey for toggling explorer window
map <leader>e :20Lex<CR>
endif

"""" Neovim Explorer
if has('nvim')
nnoremap <leader>e :NvimTreeFindFileToggle<CR>
endif

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
Plug 'itchyny/lightline.vim'
if has('nvim')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
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


"""""""""""""""
""""""" COLORS
"""""""""""""""
" Enable better color support"
if (has("termguicolors"))
    set termguicolors
endif

" Set colorscheme
colorscheme molokai

" Use 256-color support for molokai scheme
let g:rehash256 = 1

" Make background transparent
hi Normal guibg=NONE ctermbg=NONE

" Configure lightline
let g:lightline = {
  \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
  \ }
" We see the mode in lightline, so we deactivate it in vim
set noshowmode

""""""""""""""""""""
""""""" NEOVIM ONLY
""""""""""""""""""""
if has('nvim')
lua << EOF

-- Setup treeview
require'nvim-tree'.setup{
disable_netrw = true,
open_on_setup = true,
open_on_tab = true,
hijack_cursor = true
}

-- Setup nvim language servers
-- Rust
require('rust-tools').setup({})
-- Python
require'lspconfig'.pyright.setup{}
-- Typescript
require'lspconfig'.tsserver.setup{}
-- Solidity
require'lspconfig'.solc.setup{}
EOF

"""""""""""""""""""
""""""" LSP CONFIG
"""""""""""""""""""
" Auto fmt .rs files before saving
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

" Now we map some hotkeys for code navigation
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>

"""""""""""""""""""""
""""""" CMP CONFIG
"""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua << EOF
  -- Setup nvim-cmp
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })

  -- Setup lspconfig for rust-analyzer
  require('lspconfig').rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

endif
