# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u|\w]\$'
export EDITOR=/usr/bin/nvim
export BAT_PAGER="less -MRF"

# Clear terminal history
alias delhistory='cat /dev/null > ~/.bash_history && history -c'

# Some frequent shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ls='exa'
alias ll='exa -alF'
alias tree='exa -lF --tree --git-ignore'
alias gs='git status'
alias fu='sudo !!'

# We can query the internet for awesome terminal command help
function cheat() {
    curl cht.sh/$1
}

# Lookup weather in city ...
function weather() {
    curl wttr.in/$1
}

# Replace capslock with additional CTRL
setxkbmap -option caps:ctrl_modifier

# Source rust stuff
. "$HOME/.cargo/env"

# Source node-version manager
. "/usr/share/nvm/init-nvm.sh"

