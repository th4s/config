# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u|\w]\$'
export EDITOR=/usr/bin/nvim

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

function cheat() {
    curl cht.sh/$1
}

function weather() {
    curl wttr.in/$1
}
. "$HOME/.cargo/env"
