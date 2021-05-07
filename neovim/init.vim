" We use the vim config file ~/.vimrc also for neovim
" Put this file into ~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
