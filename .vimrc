" IMPORTANT: Make sure to install the rust tools 'bat', 'ripgrep'
" 'rust_analyzer', 'rust-src', 'xclip'
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

" Add syntax highlightning an file type identification, plugin and indenting
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

" Set text width to 80 characters
set textwidth=80

" Load local project .nvimrc files
set exrc


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

" Show current open buffers
nnoremap <leader>, :ls<CR>

" Suspend vim with shortcut (move process to background and then type 'fg' to return to vim)
nnoremap <C-s> :sus<CR>
vnoremap <C-s> :sus<CR>
inoremap <C-s> :sus<CR>

" Quick save
nnoremap <C-w> :w<CR>
inoremap <C-w> <C-o>:w<CR>

" Quick window mode
nnoremap <leader>w <C-w>

" Create new tab and close tab
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Quickly navigate to an open tab with leader key and number
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
inoremap <A-1> <C-o>1gt
inoremap <A-2> <C-o>2gt
inoremap <A-3> <C-o>3gt
inoremap <A-4> <C-o>4gt

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

" We want to be able to copy from vim to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

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

" Use spellchecking and add toggle button
set spelllang=en
nnoremap <silent> <F12> :set spell!<cr>
inoremap <silent> <F12> <C-O>:set spell!<cr>
" Activate spell checking by default
set spell

" We want to compile markdown files to pdf when we save them
" We also add a :preview command and map it to F9
autocmd BufWritePost *.md :silent !pandoc <afile>:p -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=gray -o /tmp/vim/preview/<afile>:t:r.pdf
command! Preview !xdg-open /tmp/vim/preview/%:t:r.pdf
map <F9> :Preview<CR><CR>

" Remap some mappings in diff mode
if &diff
    " go to next diff
    nnoremap <leader>n ]c
    " go to previous diff
    nnoremap <leader>p [c

    " this is for merging
    nnoremap <leader>1 :diffget LOCAL<CR>
    nnoremap <leader>2 :diffget BASE<CR>
    nnoremap <leader>3 :diffget REMOTE<CR>
endif

""""""""""""""""""
""""""""" EXPLORER
""""""""""""""""""
"""" Neovim Explorer
if has('nvim')
nnoremap <leader>e :NvimTreeFindFileToggle<CR>
else
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' 
Plug 'itchyny/lightline.vim'
if has('nvim')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
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
hi TablineSel guibg=RED ctermbg=RED

" Configure lightline
let g:lightline = {
  \ 'colorscheme': 'molokai',
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
require('nvim-tree').setup({
disable_netrw = true,
open_on_tab = true,
hijack_cursor = true,
sort_by = function(nodes)
    table.sort(nodes, function(a, b)
        if a.type ~= b.type then
            return a.type == "file"
        else
            return a.name < b.name
        end
    end)
end
})

-- Python
require'lspconfig'.pyright.setup{}
-- Typescript
require'lspconfig'.tsserver.setup{}

EOF
endif

" Autoformat all the code
" 
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)

if has('nvim')
lua << EOF
----------------------------------
-------------- RUST --------------
----------------------------------

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
    local keymap_opts = { buffer = buffer }
    -- Code navigation and shortcuts
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
    vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, keymap_opts)

    -- Show diagnostic popup on cursor hover
    local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
      group = diag_float_grp,
    })
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attaches to the buffer
    on_attach = on_attach,
    root_dir = vim.lsp.util.find_git_ancestor,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
        imports = {
                granularity = {
                    group = "crate",
                },
                prefix = "self",
            },
      },
    },
  },
}

require("rust-tools").setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"

-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
vim.opt.updatetime = 100

EOF
endif
